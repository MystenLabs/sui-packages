module 0x17ccd40cee0580de803305c2a03251479921c6ae19488ed60198d45f447e16c8::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 6, b"BBC", b"Broke Boys Club", b"$BBC is the first token to celebrate your fantastic crypto failures. Ever sold a token before it exploded in value? perfect! $BBC welcomes you with open arms and a round of commiserative laughter. We're not just about losing gracefully, we're about turning those losses into clout! The bigger your financial faux pas, the bigger your airdrop.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_54ca67039e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

