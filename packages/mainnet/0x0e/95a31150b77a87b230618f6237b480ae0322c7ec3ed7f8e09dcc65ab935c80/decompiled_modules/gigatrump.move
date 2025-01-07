module 0xe95a31150b77a87b230618f6237b480ae0322c7ec3ed7f8e09dcc65ab935c80::gigatrump {
    struct GIGATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGATRUMP>(arg0, 9, b"GIGATRUMP", b"Giga Trump", b"Giga Trump on $SUI - Make great Sui Again Chads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmeL7S2PRnc4KNkWUmHuvrErgZmagSfaayAcPiqxsnqd2A?img-width=800&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIGATRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGATRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

