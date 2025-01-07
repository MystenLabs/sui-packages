module 0xd4c96278235780e420cf1abd08d313f544fc4fc80e1d891e087309c0a5756c28::suirek {
    struct SUIREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREK>(arg0, 6, b"SUIREK", b"Sui Rek", x"2453554952454b28536872656b2920697320696e74726f6475636564206173206120736f6c69746172792c2067726f75636879206f677265206c6976696e6720696e20612072656d6f7465207377616d702e20486520656e6a6f797320686973207072697661637920616e6420667269676874656e73206f666620616e792068756d616e732077686f20636f6d65206e6561722068696d2e20235355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Rek_6ba37a4761.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

