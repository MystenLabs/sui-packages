module 0x40fbb1a5c4e811a2254d0c2ce157c005f596dd320dc941f3fdf068bdd7166a49::crypto_streaming {
    struct StreamRegistry has store, key {
        id: 0x2::object::UID,
        sender_to_streams: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        recipient_to_streams: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct Stream has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        owner: address,
        start_date: u64,
        recipient: address,
        frequency: u64,
        release_number: u64,
        release_amount: u64,
        created_date: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        withdrew: u64,
        status: u64,
    }

    public entry fun create_streams(arg0: &mut StreamRegistry, arg1: vector<u8>, arg2: u64, arg3: vector<address>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = Stream{
                id             : 0x2::object::new(arg8),
                title          : 0x1::string::utf8(arg1),
                owner          : v0,
                start_date     : arg2,
                recipient      : *0x1::vector::borrow<address>(&arg3, v1),
                frequency      : *0x1::vector::borrow<u64>(&arg4, v1),
                release_number : *0x1::vector::borrow<u64>(&arg5, v1),
                release_amount : *0x1::vector::borrow<u64>(&arg6, v1),
                created_date   : 0x2::clock::timestamp_ms(arg7),
                balance        : 0x2::balance::zero<0x2::sui::SUI>(),
                withdrew       : 0,
                status         : 1,
            };
            if (!0x2::vec_map::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.recipient_to_streams, 0x1::vector::borrow<address>(&arg3, v1))) {
                0x2::vec_map::insert<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.recipient_to_streams, *0x1::vector::borrow<address>(&arg3, v1), 0x2::vec_set::empty<0x2::object::ID>());
            };
            0x2::vec_set::insert<0x2::object::ID>(0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.recipient_to_streams, 0x1::vector::borrow<address>(&arg3, v1)), 0x2::object::id<Stream>(&v2));
            if (!0x2::vec_map::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.sender_to_streams, &v0)) {
                0x2::vec_map::insert<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.sender_to_streams, v0, 0x2::vec_set::empty<0x2::object::ID>());
            };
            0x2::vec_set::insert<0x2::object::ID>(0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.sender_to_streams, &v0), 0x2::object::id<Stream>(&v2));
            0x2::transfer::share_object<Stream>(v2);
            v1 = v1 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StreamRegistry{
            id                   : 0x2::object::new(arg0),
            sender_to_streams    : 0x2::vec_map::empty<address, 0x2::vec_set::VecSet<0x2::object::ID>>(),
            recipient_to_streams : 0x2::vec_map::empty<address, 0x2::vec_set::VecSet<0x2::object::ID>>(),
        };
        0x2::transfer::share_object<StreamRegistry>(v0);
    }

    public entry fun send_fund(arg0: &mut Stream, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(&arg0.owner == &v0, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public entry fun withdraw(arg0: &mut Stream, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(&arg0.recipient == &v0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 > arg0.start_date, 1);
        let v2 = (v1 - arg0.start_date) / arg0.frequency;
        let v3 = v2;
        if (v2 > arg0.release_number) {
            v3 = arg0.release_number;
            arg0.status = 2;
        };
        let v4 = v3 * arg0.release_amount - arg0.withdrew;
        let v5 = &mut arg0.withdrew;
        *v5 = *v5 + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v4, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

