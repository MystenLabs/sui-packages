module 0x34dedf07aa5eeebbf738b37a407aabf8d74952784c778a838b55c83ac4bc8649::sojh_sui {
    struct SOJH_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOJH_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOJH_SUI>(arg0, 9, b"sojhSUI", b"josh Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAANCAYAAACD4L/xAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAXSURBVBhXY/z49ed/BgYGBiYGKKADAwDBKQP43w5qJQAAAABJRU5ErkJggg==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOJH_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOJH_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

