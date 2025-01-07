module 0xb215ce561e083bdcad72b9d35da8f4d400651b4bba914845b3908061fa4d6015::ne365 {
    struct NE365 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NE365, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NE365>(arg0, 9, b"NE365", b"Never E365", b"Community fun token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1aeb9fb-b50d-4e5b-815f-4b3665b14223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NE365>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NE365>>(v1);
    }

    // decompiled from Move bytecode v6
}

