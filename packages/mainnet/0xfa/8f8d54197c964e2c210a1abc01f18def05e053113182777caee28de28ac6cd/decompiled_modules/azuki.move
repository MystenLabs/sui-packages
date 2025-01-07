module 0xfa8f8d54197c964e2c210a1abc01f18def05e053113182777caee28de28ac6cd::azuki {
    struct AZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZUKI>(arg0, 9, b"AZUKI", b"AZUKI", b"AZUKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lh5.googleusercontent.com/Yi4Ay3xS8mC19uc6AG32GmhNPmLDnRWqfGkCpiV3NCKfHP-7hMjdTeGN741PuAva_obrASnBfhZ9eRF3grnBUWew9s80mrMp_i6JvE5WLS-gYQRkBX-7dVJ-8B6AS05qLell0QinO4zd2PjT51REXaJRXZ_gAyb4-DiGqpnTm38RRUvT_t1Rc8klBQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AZUKI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZUKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUKI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

