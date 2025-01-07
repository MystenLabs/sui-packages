module 0x371438302a20216323c87a858825c4f6c8407b77467312dd097d584de54ea537::iwy {
    struct IWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWY>(arg0, 6, b"IWY", b"I WANT YOU", b"I WANT YOU...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_120748989_1024x1024_81f308f5b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

