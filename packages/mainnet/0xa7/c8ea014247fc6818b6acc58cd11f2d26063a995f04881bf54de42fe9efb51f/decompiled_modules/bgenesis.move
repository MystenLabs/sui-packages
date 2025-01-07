module 0xa7c8ea014247fc6818b6acc58cd11f2d26063a995f04881bf54de42fe9efb51f::bgenesis {
    struct BGENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGENESIS>(arg0, 9, b"BGENESIS", b"Bitcoin Genesis", x"4f6e204a616e756172792033726420323030392c2074686520426974636f696e206e6574776f726b207761732063726561746564207768656e205361746f736869204e616b616d61746f206d696e65642074686520e2809c47656e65736973e2809d20626c6f636b2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x8baf5d75cae25c7df6d1e0d26c52d19ee848301a.png?size=xl&key=a459db")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BGENESIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGENESIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGENESIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

