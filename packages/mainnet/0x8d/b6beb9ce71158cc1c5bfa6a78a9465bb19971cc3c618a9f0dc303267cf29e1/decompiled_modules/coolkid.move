module 0x8db6beb9ce71158cc1c5bfa6a78a9465bb19971cc3c618a9f0dc303267cf29e1::coolkid {
    struct COOLKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLKID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLKID>(arg0, 6, b"CoolKid", b"Cool Kid", x"5269676874206261636b2061746368612062756464792e0a536f6c206861732073756363657373206b6964207375692068617320636f6f6c206b69642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/undefined_Imgur_a636f8762e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLKID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLKID>>(v1);
    }

    // decompiled from Move bytecode v6
}

