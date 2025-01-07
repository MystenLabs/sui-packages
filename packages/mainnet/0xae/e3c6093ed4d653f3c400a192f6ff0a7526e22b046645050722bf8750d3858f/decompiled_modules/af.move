module 0xaee3c6093ed4d653f3c400a192f6ff0a7526e22b046645050722bf8750d3858f::af {
    struct AF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF>(arg0, 9, b"AF", b"fsafsa", b"DGSAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6696b532-550c-44a1-a61f-bb441dc634b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF>>(v1);
    }

    // decompiled from Move bytecode v6
}

