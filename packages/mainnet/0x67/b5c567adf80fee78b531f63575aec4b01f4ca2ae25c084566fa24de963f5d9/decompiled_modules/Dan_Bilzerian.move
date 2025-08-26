module 0x67b5c567adf80fee78b531f63575aec4b01f4ca2ae25c084566fa24de963f5d9::Dan_Bilzerian {
    struct DAN_BILZERIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN_BILZERIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAN_BILZERIAN>(arg0, 9, b"DAN", b"Dan Bilzerian", b"idgaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841837652443856898/IqxLiFXL_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAN_BILZERIAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAN_BILZERIAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

