module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::trade {
    struct Trade has key {
        id: 0x2::object::UID,
        state: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::TradeState,
        sui_a: 0x2::balance::Balance<0x2::sui::SUI>,
        sui_b: 0x2::balance::Balance<0x2::sui::SUI>,
        kares_a: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
        kares_b: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
        caps_a: vector<0x2::object::ID>,
        caps_b: vector<0x2::object::ID>,
    }

    public fun join(arg0: &mut Trade, arg1: u64, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::join(&mut arg0.state, arg1, 0x2::tx_context::sender(arg3));
    }

    public fun accept(arg0: &mut Trade, arg1: u64, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::accept(&mut arg0.state, arg1, 0x2::tx_context::sender(arg3));
    }

    public fun cancel(arg0: &mut Trade, arg1: u64, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::cancel(&mut arg0.state, arg1, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun claim_item(arg0: &mut Trade, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) : (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item, 0x2::transfer_policy::TransferRequest<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>) {
        0x2::kiosk::purchase_with_cap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg2, take_terminal_cap(arg0, arg1, false, 0x2::tx_context::sender(arg3)), 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    public fun claim_kares(arg0: &mut Trade, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg1);
        take_terminal_kares(arg0, false, arg2)
    }

    public fun claim_sui(arg0: &mut Trade, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg1);
        take_terminal_sui(arg0, false, arg2)
    }

    public fun close(arg0: Trade, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg1);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_terminal(&arg0.state);
        destroy_drained(arg0, arg2);
    }

    public fun create(arg0: address, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg1);
        let v0 = Trade{
            id      : 0x2::object::new(arg2),
            state   : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::new(0x2::tx_context::sender(arg2), arg0),
            sui_a   : 0x2::balance::zero<0x2::sui::SUI>(),
            sui_b   : 0x2::balance::zero<0x2::sui::SUI>(),
            kares_a : 0x2::balance::zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(),
            kares_b : 0x2::balance::zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(),
            caps_a  : 0x1::vector::empty<0x2::object::ID>(),
            caps_b  : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Trade>(v0);
    }

    fun destroy_drained(arg0: Trade, arg1: &0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_party(&arg0.state, 0x2::tx_context::sender(arg1));
        let Trade {
            id      : v0,
            state   : _,
            sui_a   : v2,
            sui_b   : v3,
            kares_a : v4,
            kares_b : v5,
            caps_a  : v6,
            caps_b  : v7,
        } = arg0;
        let v8 = v7;
        let v9 = v6;
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_drained(0x1::vector::length<0x2::object::ID>(&v9), 0x1::vector::length<0x2::object::ID>(&v8));
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        0x2::balance::destroy_zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(v4);
        0x2::balance::destroy_zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(v5);
        0x2::object::delete(v0);
    }

    public fun end_request(arg0: Trade, arg1: u64, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_request_exit(&arg0.state, arg1, 0x2::tx_context::sender(arg3));
        destroy_drained(arg0, arg3);
    }

    fun my_kares_balance(arg0: &mut Trade, arg1: address) : &mut 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::is_initiator(&arg0.state, arg1)) {
            &mut arg0.kares_a
        } else {
            &mut arg0.kares_b
        }
    }

    fun my_manifest(arg0: &mut Trade, arg1: address) : &mut vector<0x2::object::ID> {
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::is_initiator(&arg0.state, arg1)) {
            &mut arg0.caps_a
        } else {
            &mut arg0.caps_b
        }
    }

    fun my_sui_balance(arg0: &mut Trade, arg1: address) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::is_initiator(&arg0.state, arg1)) {
            &mut arg0.sui_a
        } else {
            &mut arg0.sui_b
        }
    }

    public(friend) fun put_item(arg0: &mut Trade, arg1: 0x2::kiosk::PurchaseCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_editable(&arg0.state, arg2, 0x2::tx_context::sender(arg3));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_zero_price(0x2::kiosk::purchase_cap_min_price<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(&arg1));
        let v0 = 0x2::kiosk::purchase_cap_item<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(&arg1);
        let v1 = my_manifest(arg0, 0x2::tx_context::sender(arg3));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_cap_room(0x1::vector::length<0x2::object::ID>(v1));
        0x1::vector::push_back<0x2::object::ID>(v1, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>>(&mut arg0.id, v0, arg1);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::touch(&mut arg0.state);
    }

    public fun put_kares(arg0: &mut Trade, arg1: 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, arg2: u64, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg3);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_editable(&arg0.state, arg2, 0x2::tx_context::sender(arg4));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_positive(0x2::coin::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg1));
        let v0 = my_kares_balance(arg0, 0x2::tx_context::sender(arg4));
        0x2::balance::join<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(v0, 0x2::coin::into_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(arg1));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::touch(&mut arg0.state);
    }

    public fun put_sui(arg0: &mut Trade, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg3);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_editable(&arg0.state, arg2, 0x2::tx_context::sender(arg4));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_positive(0x2::coin::value<0x2::sui::SUI>(&arg1));
        let v0 = my_sui_balance(arg0, 0x2::tx_context::sender(arg4));
        0x2::balance::join<0x2::sui::SUI>(v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::touch(&mut arg0.state);
    }

    public(friend) fun recover_item(arg0: &mut Trade, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item> {
        take_terminal_cap(arg0, arg1, true, 0x2::tx_context::sender(arg2))
    }

    public fun recover_kares(arg0: &mut Trade, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg1);
        take_terminal_kares(arg0, true, arg2)
    }

    public fun recover_sui(arg0: &mut Trade, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg1);
        take_terminal_sui(arg0, true, arg2)
    }

    fun remove_from(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        0x1::vector::remove<0x2::object::ID>(arg0, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::item_index(arg0, arg1));
    }

    public(friend) fun take_item(arg0: &mut Trade, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item> {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_editable(&arg0.state, arg2, 0x2::tx_context::sender(arg3));
        let v0 = my_manifest(arg0, 0x2::tx_context::sender(arg3));
        remove_from(v0, arg1);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::touch(&mut arg0.state);
        0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>>(&mut arg0.id, arg1)
    }

    public fun take_kares(arg0: &mut Trade, arg1: u64, arg2: u64, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg3);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_editable(&arg0.state, arg2, 0x2::tx_context::sender(arg4));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_positive(arg1);
        let v0 = my_kares_balance(arg0, 0x2::tx_context::sender(arg4));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::touch(&mut arg0.state);
        0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(v0, arg1), arg4)
    }

    public fun take_sui(arg0: &mut Trade, arg1: u64, arg2: u64, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg3);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_editable(&arg0.state, arg2, 0x2::tx_context::sender(arg4));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_positive(arg1);
        let v0 = my_sui_balance(arg0, 0x2::tx_context::sender(arg4));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::touch(&mut arg0.state);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v0, arg1), arg4)
    }

    fun take_terminal_cap(arg0: &mut Trade, arg1: 0x2::object::ID, arg2: bool, arg3: address) : 0x2::kiosk::PurchaseCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item> {
        let v0 = if (arg2) {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::cancelled()
        } else {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::settling()
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_phase(&arg0.state, v0);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_party(&arg0.state, arg3);
        let v1 = if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::is_initiator(&arg0.state, arg3) == arg2) {
            &mut arg0.caps_a
        } else {
            &mut arg0.caps_b
        };
        remove_from(v1, arg1);
        0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>>(&mut arg0.id, arg1)
    }

    fun take_terminal_kares(arg0: &mut Trade, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        let v0 = if (arg1) {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::cancelled()
        } else {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::settling()
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_phase(&arg0.state, v0);
        let v1 = 0x2::tx_context::sender(arg2);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_party(&arg0.state, v1);
        let v2 = if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::is_initiator(&arg0.state, v1) == arg1) {
            &mut arg0.kares_a
        } else {
            &mut arg0.kares_b
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_positive(0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(v2));
        0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::withdraw_all<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(v2), arg2)
    }

    fun take_terminal_sui(arg0: &mut Trade, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = if (arg1) {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::cancelled()
        } else {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::settling()
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_phase(&arg0.state, v0);
        let v1 = 0x2::tx_context::sender(arg2);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_party(&arg0.state, v1);
        let v2 = if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::is_initiator(&arg0.state, v1) == arg1) {
            &mut arg0.sui_a
        } else {
            &mut arg0.sui_b
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::trade_state::assert_positive(0x2::balance::value<0x2::sui::SUI>(v2));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(v2), arg2)
    }

    // decompiled from Move bytecode v7
}

