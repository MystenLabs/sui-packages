module 0xebecb96bc857b5012bdc7191409396d6c938eda86f0f87115929c396ff60116f::apesui {
    struct APESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APESUI>(arg0, 6, b"APESUI", b"Ape Sui", b"APESUI, The only ape that knows how to chill and thrill at the same time. Light it up with ApeSui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/184_bf2fc3d68d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

