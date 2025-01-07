module 0x9d652eba32748793b200cfeb28e4f680e44caea545d650ea1752fbaed75c6d4a::doges {
    struct DOGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGES>(arg0, 9, b"DOGES", b"Doge", x"4974e28099732061206361742c2072696768743f204275742049206c696b652063616c6c696e67206974206120646f672e20416c736f2c207468657265e2809973206e6f206d6f6e657920746f2070757368207468652070726963652075702e2042757920696620796f752077616e742c206966206e6f742c207468656e20646f6ee28099742e20496620796f75e280997265207363617265642c206a75737420676f20686f6d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1cf96b0-a6cc-4db4-bb81-2ce664e5d5ec-IMG_3520.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGES>>(v1);
    }

    // decompiled from Move bytecode v6
}

