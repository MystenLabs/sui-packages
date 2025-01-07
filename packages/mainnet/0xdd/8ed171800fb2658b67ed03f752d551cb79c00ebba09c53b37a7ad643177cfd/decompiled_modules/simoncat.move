module 0xdd8ed171800fb2658b67ed03f752d551cb79c00ebba09c53b37a7ad643177cfd::simoncat {
    struct SIMONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMONCAT>(arg0, 6, b"SIMONCAT", b"Simon's Cat", x"41726520796f752061204b697474656e206f7220612043686c6f653f2120416e73776572206120636f75706c65206f662065617379207175657374696f6e7320616e6420796f756c6c206b6e6f77207768696368206f6e65206f66207468652053696d6f6e277320436174206368617261637465727320697320796f75722062657374206d61746368210a0a456e6a6f7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015836_f314cfd3b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

