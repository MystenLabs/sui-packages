module 0x451e807c8b5ab9cddff7c0dad96ac80ee98e0332e7da070a4d6038c5d65a670a::SuiFlokiInu {
    struct SUIFLOKIINU has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIFLOKIINU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIFLOKIINU>>(arg0, arg1);
    }

    fun init(arg0: SUIFLOKIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLOKIINU>(arg0, 9, b"$SFI", b"SuiFlokiInu", b"We are the first meme token on sui Blockchain, powering Ai and promoting meme culture.Meme is life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/flo.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIFLOKIINU>(&mut v2, 600000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLOKIINU>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFLOKIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

