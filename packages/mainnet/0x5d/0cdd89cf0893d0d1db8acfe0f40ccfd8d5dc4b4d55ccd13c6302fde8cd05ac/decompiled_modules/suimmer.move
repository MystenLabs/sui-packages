module 0x5d0cdd89cf0893d0d1db8acfe0f40ccfd8d5dc4b4d55ccd13c6302fde8cd05ac::suimmer {
    struct SUIMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMMER>(arg0, 6, b"SUIMMER", b"Suimming Doggo", x"48657920697473206d6520796f757220446f67676f210a4c6561726e7420686f7720746f205355496d2066726f6d2064612062657374206f66207a612062657374210a0a4261726b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_5881_85827a7374.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

