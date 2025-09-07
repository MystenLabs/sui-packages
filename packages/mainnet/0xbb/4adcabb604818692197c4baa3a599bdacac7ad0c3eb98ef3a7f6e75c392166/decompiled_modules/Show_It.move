module 0xbb4adcabb604818692197c4baa3a599bdacac7ad0c3eb98ef3a7f6e75c392166::Show_It {
    struct SHOW_IT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOW_IT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOW_IT>(arg0, 9, b"SHOW", b"Show It", b"show me it ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0NZoQNXYAA2z8N?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOW_IT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOW_IT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

