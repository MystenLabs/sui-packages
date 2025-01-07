module 0x62b074778dba110e34b41ab40932c5d0323ef35107cdf6662292a97255aaeb85::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 8, b"HIPPO", b"sudeng", b"The $HIPPO community has taken over after the original developer abandoned the project. Rather than letting it fade, the community has stepped in to breathe new life into $HIPPO, transforming it into a truly decentralized, community - driven meme token. This is a fresh start for $HIPPO, now fully powered by the people!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

