module 0x667cb59712bd369b6fc2c505e3eb1f561fb4b76272a8d51709b87b7c6ab05a40::psy {
    struct PSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSY>(arg0, 9, b"PSY", b"Psychedelic Sui", b"Psychedelic Sui, the cosmic mushroom of boundless ambition, is here to redefine the crypto universe. Fueled by an unstoppable drive to Shroom into realms of billions. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b08141564a09884ba36cdb7f57efe797blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

