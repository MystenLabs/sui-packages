module 0xa57fc35fa155c289a6c32638793330803404d6eb3dd9d8c31a2f109c64c3ce72::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCOIN>(arg0, 6, b"Fartcoin", b"FartCoin", x"546f6b656e697a696e672046617274732077697468207468652068656c70206f6620626f74732e205765e2809976652061646f7074656420244641525420636f696e20616e642062726f7567687420697420746f20245355492e204e6f20727567732c206e6f20736b656d732c206661727420667265656c79212046617274636f696e6f662e537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737657960760.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

