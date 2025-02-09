module 0xf7137350029fa7d47826ac0c3dc0e409bd30a62aac3123215e9e103ad2c3a01c::pcrz {
    struct PCRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCRZ>(arg0, 6, b"PCRZ", b"PuntoDecruZNft", x"224e75657374726f20746f6b656e204e465420656e2043727970746f2e636f6d20657374c3a12064697365c3b161646f20706172612061706f7961722061206c6f73206172746573616e6f7320656e206c6120637265616369c3b36e206465206f62726173206465206172746520656e2074656c612e2043616461204e465420726570726573656e746120756e61207069657a6120c3ba6e69636120646520617274652c2063726561646120706f722074616c656e746f736f73206172746573616e6f7320717565207574696c697a616e2074c3a9636e6963617320747261646963696f6e616c65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739074044433.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCRZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCRZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

