module 0xde48ed345cc2a5111b6716d83df9f1e12a68bd37366fb23dcdc129f5dea82771::persona_sui {
    struct PERSONA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERSONA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERSONA_SUI>(arg0, 9, b"personaSUI", b"persona Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAECAYAAACk7+45AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAXSURBVBhXY/z///9/BgYGBiYGKMBkAACGLgQEllwMjQAAAABJRU5ErkJggg==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERSONA_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERSONA_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

