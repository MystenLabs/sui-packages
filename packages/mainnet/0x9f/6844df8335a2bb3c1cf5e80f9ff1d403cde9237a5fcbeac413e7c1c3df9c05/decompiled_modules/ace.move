module 0x9f6844df8335a2bb3c1cf5e80f9ff1d403cde9237a5fcbeac413e7c1c3df9c05::ace {
    struct ACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACE>(arg0, 6, b"Ace", b"Ace", b"Ace Of Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.neasc.org/sites/default/files/styles/large/public/2022-12/ace-logo-icon.png?itok=GY5DjoHD"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ACE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

