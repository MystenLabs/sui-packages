module 0x9f327dd7ac43ce4cd54ff17b1d7bf6dfbece797263361e11cff5a40321ec5889::pcruz {
    struct PCRUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCRUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCRUZ>(arg0, 6, b"Pcruz", b"PuntoDecruZNft", x"224e75657374726f20746f6b656e204e465420656e2043727970746f2e636f6d20657374c3a12064697365c3b161646f20706172612061706f7961722061206c6f73206172746573616e6f7320656e206c6120637265616369c3b36e206465206f62726173206465206172746520656e2074656c612e2043616461204e465420726570726573656e746120756e61207069657a6120c3ba6e69636120646520617274652c2063726561646120706f722074616c656e746f736f73206172746573616e6f7320717565207574696c697a616e2074c3a9636e6963617320747261646963696f6e616c65732e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739072788277.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCRUZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCRUZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

