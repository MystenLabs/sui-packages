module 0x5685062e83e4126003c7bda58c546ae92febd6d40a89dfeac9cfc3f947bd578d::smurf {
    struct SMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF>(arg0, 6, b"Smurf", b"Smurf Sui", b"Smurf is the legendary leader of the Smurfs, guiding his blue companions through adventures in their forest village. This project pays homage to Smurf and the beloved Smurfs universe, answering the call for nostalgic narratives in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxpww73ldqxfx47qw6v7tnjwzx2mcuvqcfjya2lvo6zzkdi476ka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMURF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

