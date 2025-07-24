module 0x98491ddf03ae604180b5ca91099a07f3412cdd821f8d862c1c09bed02ad85002::mc {
    struct MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC>(arg0, 6, b"MC", b"Molten Coin", b"The very crypto coin that mirrors yer Molten Ledger gold!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/molten_coin_gimp_1f8f2fa605.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MC>>(v1);
    }

    // decompiled from Move bytecode v6
}

