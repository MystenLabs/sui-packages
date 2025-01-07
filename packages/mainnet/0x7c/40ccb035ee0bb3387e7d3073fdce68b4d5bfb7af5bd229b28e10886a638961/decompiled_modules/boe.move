module 0x7c40ccb035ee0bb3387e7d3073fdce68b4d5bfb7af5bd229b28e10886a638961::boe {
    struct BOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOE>(arg0, 9, b"BOE", b"BEYONCE", b"Meme beyonce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fcb3784-ca42-4ca9-8ac5-3c76af474e4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

