module 0xa91c9ecd2cf29cf24a57e66884dbc1cab28ba378ae5e530005d4577bdfe45680::blaze {
    struct BLAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAZE>(arg0, 6, b"BLAZE", b"BlazeSui", b"BlazeSui | Igniting the Sui ecosystem with fiery energy & unstoppable growth! Join the revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidhl6u3vxepg5or2jblrua2gl7uiqrhvk7neknzvlmjsp5kwrejby")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAZE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

