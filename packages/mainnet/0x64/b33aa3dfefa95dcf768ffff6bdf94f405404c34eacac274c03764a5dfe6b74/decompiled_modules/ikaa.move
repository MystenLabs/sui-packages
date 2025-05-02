module 0x64b33aa3dfefa95dcf768ffff6bdf94f405404c34eacac274c03764a5dfe6b74::ikaa {
    struct IKAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKAA>(arg0, 9, b"IKAa", b"IKA airdrop", b"Celebration about the IKA token that will be airdropped soon. The blockchain revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/829ca9692dc980676d07848d54da9c70blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

