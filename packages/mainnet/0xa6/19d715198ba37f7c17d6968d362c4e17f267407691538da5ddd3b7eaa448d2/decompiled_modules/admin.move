module 0xa619d715198ba37f7c17d6968d362c4e17f267407691538da5ddd3b7eaa448d2::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GalleryData has key {
        id: 0x2::object::UID,
        fee: u64,
        addresses: vector<address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        blobs: vector<0x1::string::String>,
    }

    fun add_address(arg0: &mut GalleryData, arg1: address) {
        0x1::vector::push_back<address>(&mut arg0.addresses, arg1);
    }

    public fun add_blob(arg0: &mut GalleryData, arg1: &AdminCap, arg2: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.blobs, arg2);
    }

    public(friend) fun get_fee(arg0: &GalleryData) : u64 {
        arg0.fee
    }

    public(friend) fun handle_payment(arg0: &mut GalleryData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        add_address(arg0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GalleryData{
            id        : 0x2::object::new(arg0),
            fee       : 100000000,
            addresses : 0x1::vector::empty<address>(),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            blobs     : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<GalleryData>(v1);
    }

    public fun withdraw(arg0: &mut GalleryData, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

