module 0x5c1ef1e8f552371fb7b83196392e593d0d51eb75e3197d769ed93530f681b39e::ploofy {
    struct PLOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOOFY>(arg0, 6, b"PLOOFY", b"Ploofy sui", b"$PLOOFY is the baby whale thats here to pump, splash, and disrupt the crypto seas. Just pure degen fun. Ready to ride the wave?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cfc96732_9848_4210_9576_b79772482fbf_3cecb0b6c7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

