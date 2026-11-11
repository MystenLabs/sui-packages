module 0x7c07a8df79e3f5b92c3b7352c06bce2b28ba1381d5724af6c3db8d19cef8063d::unlock {
    struct Listing<phantom T0> has key {
        id: 0x2::object::UID,
        app: vector<u8>,
        item: vector<u8>,
        payees: vector<address>,
        amounts: vector<u64>,
        price: u64,
        active: bool,
        sold: u64,
    }

    struct ListingCap has store, key {
        id: 0x2::object::UID,
        listing: 0x2::object::ID,
    }

    struct UnlockReceipt has store, key {
        id: 0x2::object::UID,
        listing: 0x2::object::ID,
        app: vector<u8>,
        item: vector<u8>,
    }

    struct Listed has copy, drop {
        listing: 0x2::object::ID,
        app: vector<u8>,
        item: vector<u8>,
        price: u64,
    }

    struct Repriced has copy, drop {
        listing: 0x2::object::ID,
        price: u64,
        active: bool,
    }

    struct Bought has copy, drop {
        listing: 0x2::object::ID,
        receipt: 0x2::object::ID,
        buyer: address,
        recipient: address,
        price: u64,
    }

    public fun buy<T0>(arg0: &mut Listing<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        buy_for<T0>(arg0, arg1, v0, arg2);
    }

    public fun buy_for<T0>(arg0: &mut Listing<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(0x2::balance::value<T0>(&arg1) == arg0.price, 3);
        let v0 = 0x1::vector::length<address>(&arg0.payees);
        let v1 = 0;
        while (v1 + 1 < v0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg1, *0x1::vector::borrow<u64>(&arg0.amounts, v1)), *0x1::vector::borrow<address>(&arg0.payees, v1));
            v1 = v1 + 1;
        };
        0x2::balance::send_funds<T0>(arg1, *0x1::vector::borrow<address>(&arg0.payees, v0 - 1));
        arg0.sold = arg0.sold + 1;
        let v2 = UnlockReceipt{
            id      : 0x2::object::new(arg3),
            listing : 0x2::object::id<Listing<T0>>(arg0),
            app     : arg0.app,
            item    : arg0.item,
        };
        let v3 = Bought{
            listing   : 0x2::object::id<Listing<T0>>(arg0),
            receipt   : 0x2::object::id<UnlockReceipt>(&v2),
            buyer     : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            price     : arg0.price,
        };
        0x2::event::emit<Bought>(v3);
        0x2::transfer::public_transfer<UnlockReceipt>(v2, arg2);
    }

    public fun cap_listing(arg0: &ListingCap) : 0x2::object::ID {
        arg0.listing
    }

    fun check_parts(arg0: &vector<address>, arg1: &vector<u64>) : u64 {
        let v0 = 0x1::vector::length<address>(arg0);
        let v1 = if (v0 >= 1) {
            if (v0 <= 4) {
                v0 == 0x1::vector::length<u64>(arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            assert!(*0x1::vector::borrow<u64>(arg1, v3) > 0, 0);
            let v4 = v3 + 1;
            while (v4 < v0) {
                assert!(*0x1::vector::borrow<address>(arg0, v3) != *0x1::vector::borrow<address>(arg0, v4), 0);
                v4 = v4 + 1;
            };
            v2 = v2 + *0x1::vector::borrow<u64>(arg1, v3);
            v3 = v3 + 1;
        };
        v2
    }

    public fun create_listing<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : ListingCap {
        assert!(!0x1::vector::is_empty<u8>(&arg0) && 0x1::vector::length<u8>(&arg0) <= 64, 1);
        assert!(!0x1::vector::is_empty<u8>(&arg1) && 0x1::vector::length<u8>(&arg1) <= 64, 1);
        let v0 = check_parts(&arg2, &arg3);
        let v1 = Listing<T0>{
            id      : 0x2::object::new(arg4),
            app     : arg0,
            item    : arg1,
            payees  : arg2,
            amounts : arg3,
            price   : v0,
            active  : true,
            sold    : 0,
        };
        let v2 = 0x2::object::id<Listing<T0>>(&v1);
        let v3 = Listed{
            listing : v2,
            app     : v1.app,
            item    : v1.item,
            price   : v0,
        };
        0x2::event::emit<Listed>(v3);
        0x2::transfer::share_object<Listing<T0>>(v1);
        ListingCap{
            id      : 0x2::object::new(arg4),
            listing : v2,
        }
    }

    fun has_access(arg0: &vector<u8>, arg1: &UnlockReceipt) : bool {
        let v0 = 0x2::object::id_to_bytes(&arg1.listing);
        if (0x1::vector::length<u8>(arg0) < 0x1::vector::length<u8>(&v0)) {
            return false
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(&v0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun is_active<T0>(arg0: &Listing<T0>) : bool {
        arg0.active
    }

    public fun price<T0>(arg0: &Listing<T0>) : u64 {
        arg0.price
    }

    public fun receipt_listing(arg0: &UnlockReceipt) : 0x2::object::ID {
        arg0.listing
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &UnlockReceipt) {
        assert!(has_access(&arg0, arg1), 5);
    }

    public fun set_active<T0>(arg0: &ListingCap, arg1: &mut Listing<T0>, arg2: bool) {
        assert!(arg0.listing == 0x2::object::id<Listing<T0>>(arg1), 4);
        arg1.active = arg2;
        let v0 = Repriced{
            listing : 0x2::object::id<Listing<T0>>(arg1),
            price   : arg1.price,
            active  : arg2,
        };
        0x2::event::emit<Repriced>(v0);
    }

    public fun set_parts<T0>(arg0: &ListingCap, arg1: &mut Listing<T0>, arg2: vector<address>, arg3: vector<u64>) {
        assert!(arg0.listing == 0x2::object::id<Listing<T0>>(arg1), 4);
        arg1.price = check_parts(&arg2, &arg3);
        arg1.payees = arg2;
        arg1.amounts = arg3;
        let v0 = Repriced{
            listing : 0x2::object::id<Listing<T0>>(arg1),
            price   : arg1.price,
            active  : arg1.active,
        };
        0x2::event::emit<Repriced>(v0);
    }

    public fun sold<T0>(arg0: &Listing<T0>) : u64 {
        arg0.sold
    }

    // decompiled from Move bytecode v7
}

