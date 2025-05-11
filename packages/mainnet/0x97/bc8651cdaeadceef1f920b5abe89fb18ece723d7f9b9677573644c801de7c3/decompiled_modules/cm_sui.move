module 0x97bc8651cdaeadceef1f920b5abe89fb18ece723d7f9b9677573644c801de7c3::cm_sui {
    struct CM_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CM_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CM_SUI>(arg0, 9, b"cmSUI", b"crypto_mykola Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMjMiIHZpZXdCb3g9IjAgMCAzMiAyMyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGcgY2xpcC1wYXRoPSJ1cmwoI2NsaXAwXzI2ODhfMzY5MykiPgo8cGF0aCBkPSJNMzAuOTk5NSAxLjVIMC45OTk1MTJWMjEuNUgzMC45OTk1VjEuNVoiIGZpbGw9ImJsYWNrIi8+CjxwYXRoIGQ9Ik0zMC45OTk1IDEuNUgxMC45OTk1VjIxLjVIMzAuOTk5NVYxLjVaIiBmaWxsPSIjRkREQTI1Ii8+CjxwYXRoIGQ9Ik0zMC45OTk1IDEuNUgyMC45OTk1VjIxLjVIMzAuOTk5NVYxLjVaIiBmaWxsPSIjRUYzMzQwIi8+CjwvZz4KPHBhdGggZD0iTTQuOTk5NTEgMUMyLjUxNDIzIDEgMC40OTk1MTIgMy4wMTQ3MiAwLjQ5OTUxMiA1LjVWMTcuNUMwLjQ5OTUxMiAxOS45ODUzIDIuNTE0MjMgMjIgNC45OTk1MSAyMkgyNi45OTk1QzI5LjQ4NDggMjIgMzEuNDk5NSAxOS45ODUzIDMxLjQ5OTUgMTcuNVY1LjVDMzEuNDk5NSAzLjAxNDcyIDI5LjQ4NDggMSAyNi45OTk1IDFINC45OTk1MVoiIHN0cm9rZT0iI0QyRDFENCIvPgo8ZGVmcz4KPGNsaXBQYXRoIGlkPSJjbGlwMF8yNjg4XzM2OTMiPgo8cGF0aCBkPSJNMC45OTk1MTIgNS41QzAuOTk5NTEyIDMuMjkwODYgMi43OTAzNyAxLjUgNC45OTk1MSAxLjVIMjYuOTk5NUMyOS4yMDg3IDEuNSAzMC45OTk1IDMuMjkwODYgMzAuOTk5NSA1LjVWMTcuNUMzMC45OTk1IDE5LjcwOTEgMjkuMjA4NyAyMS41IDI2Ljk5OTUgMjEuNUg0Ljk5OTUxQzIuNzkwMzcgMjEuNSAwLjk5OTUxMiAxOS43MDkxIDAuOTk5NTEyIDE3LjVWNS41WiIgZmlsbD0id2hpdGUiLz4KPC9jbGlwUGF0aD4KPC9kZWZzPgo8L3N2Zz4K")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CM_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CM_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

