module 0xccd26cb560807aad49add1d4312fd672ebf44eee4260aee7b874ec49bc227b9f::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 6, b"Doggo", b"DOGGO", b"Something great is happening to $DOGGO. It's the same as the repeated story of $DOGE. The owner of $DOGE sold all their tokens to buy a Honda Civic, and $DOGE became a legend. It has become one of the largest tokens in the cryptographic world. Now, the same scene is being repeated with $DOGGO. All tokens sent to the owner of $DOGE have been sold. In addition, the $DOGGO team sold all their tokens. A community is being formed here with a great narrative. Do you want to make $DOGGO a new $DOGE with us? If so, please join us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/a_ae_a_c_20240925042042_052cc584a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

