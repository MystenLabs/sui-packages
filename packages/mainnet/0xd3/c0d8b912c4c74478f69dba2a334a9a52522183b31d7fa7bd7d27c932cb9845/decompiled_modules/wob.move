module 0xd3c0d8b912c4c74478f69dba2a334a9a52522183b31d7fa7bd7d27c932cb9845::wob {
    struct WOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOB>(arg0, 6, b"WOB", b"Pokewob", x"54686520626c7565206b696e67206f6620626f756e63656261636b7320697320616c6d6f737420686572652e2063616c6d2c20636f6f6c2c20616e642061626f757420746f207368616b6520757020746865206d656d6520636f696e2067616d652e0a0a4a6f696e2074686520776f62626c652e205265666c65637420746865206368616f732e20436f756e74657220746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5qvsog2wzqsxyaskqh4tflbj63yuziwcbi73bfmibz66h6e4tt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

