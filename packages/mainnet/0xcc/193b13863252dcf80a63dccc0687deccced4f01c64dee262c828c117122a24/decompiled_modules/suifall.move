module 0xcc193b13863252dcf80a63dccc0687deccced4f01c64dee262c828c117122a24::suifall {
    struct SUIFALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFALL>(arg0, 6, b"SUIFALL", b"Sui Waterfall", x"53756966616c6c206272696e677320746865207275736820616e6420656e65726779206f66206120776174657266616c6c2c206675656c696e6720746865206e657874206269672077617665206f6e205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suifall_0e5bf9af55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

