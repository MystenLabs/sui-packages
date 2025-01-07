module 0x948181de686aeb24e145d0bccd4327032c621dd30db330f0af0e51a4c5bf3857::point {
    struct POINT has drop {
        dummy_field: bool,
    }

    struct PointStore has key {
        id: 0x2::object::UID,
        point_treasury: 0x2::coin::TreasuryCap<POINT>,
    }

    fun init(arg0: POINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POINT>(arg0, 9, b"WBP", b"WinningBlock Point", b"Point for winningblock", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x948181de686aeb24e145d0bccd4327032c621dd30db330f0af0e51a4c5bf3857::token::new_policy<POINT>(&v2, arg1);
        let v5 = PointStore{
            id             : 0x2::object::new(arg1),
            point_treasury : v2,
        };
        0x2::transfer::share_object<PointStore>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POINT>>(v1);
        0x2::transfer::public_transfer<0x948181de686aeb24e145d0bccd4327032c621dd30db330f0af0e51a4c5bf3857::token::TokenPolicyCap<POINT>>(v4, 0x2::tx_context::sender(arg1));
        0x948181de686aeb24e145d0bccd4327032c621dd30db330f0af0e51a4c5bf3857::token::share_policy<POINT>(v3);
    }

    entry fun mint_tokens(arg0: &mut PointStore, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x948181de686aeb24e145d0bccd4327032c621dd30db330f0af0e51a4c5bf3857::token::confirm_with_treasury_cap<POINT>(&mut arg0.point_treasury, 0x948181de686aeb24e145d0bccd4327032c621dd30db330f0af0e51a4c5bf3857::token::transfer<POINT>(0x948181de686aeb24e145d0bccd4327032c621dd30db330f0af0e51a4c5bf3857::token::mint<POINT>(&mut arg0.point_treasury, arg1, arg2), 0x2::tx_context::sender(arg2), arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

