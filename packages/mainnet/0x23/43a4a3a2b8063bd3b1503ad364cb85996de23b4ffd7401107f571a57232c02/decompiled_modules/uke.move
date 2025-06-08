module 0x2343a4a3a2b8063bd3b1503ad364cb85996de23b4ffd7401107f571a57232c02::uke {
    struct UKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UKE>(arg0, 6, b"UKE", b"UNIKE", b"$UKE The Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicew3c3jcjcdltozbaaa77qsutjv63zdnidm24fv7omoeb4xknuoe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

