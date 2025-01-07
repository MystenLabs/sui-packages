module 0x64baf1f477bf6595f6fb7159a29498dfe6dce155ae813a614f3e358fa3cdd82f::sial {
    struct SIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIAL>(arg0, 6, b"SIAL", b"Sui Angel", x"48656c6c6f2062656175746966756c20616e64206b696e6420706572736f6e2e204d616b65207573207368696e65206c696b6520746865206d6f6f6e2e20492077616e7420746f206372656174652061207374726f6e6720636f6d6d756e69747920616e6420686f706520746f2066696e6420796f75206f6e206f757220736964652e0a416e64204920686f706520746f206561726e20796f75722074727573742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733459987017.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

