module 0xe4bf583fae6bea6acad14e6e230af4a10f5734e1bc605ae7364e02da585a2fe8::dogk {
    struct DOGK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGK>(arg0, 6, b"DOGK", b"DOGKING Token", b"Dontbuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

