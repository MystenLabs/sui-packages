module 0x24158df5660d51d25e2eafe6ee2ca0fc4d94c40bfec28b2f8febcc8612b4a510::dogwifchain {
    struct DOGWIFCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFCHAIN>(arg0, 6, b"DOGWIFCHAIN", b"Dog Wif Chain", x"3220646179732061676f2c2049206d65742074686520736361726965737420646f672e2024444f47574946434841494e2e2044756465207269707065642061206d6574616c20636861696e2061706172742c206579657320626c617a696e67207265642c20616e642063616d65207374726169676874206174206d652e20492072616e206c696b652068656c6c2e204e6f772068652773206f6e205375692c20736f206275636b6c652075702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogwifchain_9b821b40bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFCHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

