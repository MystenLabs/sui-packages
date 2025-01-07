module 0x8acb5f2ab00242df51b62c4c285131015beaca198b57a6ce58654ec86f6350ba::dsc {
    struct DSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSC>(arg0, 8, b"DSC", b"DeepSeaCoin", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpKh7jCYH9YIaDpcG02CCtbBszo_Q7KF6sEA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DSC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

