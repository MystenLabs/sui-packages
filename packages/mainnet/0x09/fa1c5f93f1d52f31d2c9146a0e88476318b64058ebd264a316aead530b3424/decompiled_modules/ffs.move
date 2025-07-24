module 0x9fa1c5f93f1d52f31d2c9146a0e88476318b64058ebd264a316aead530b3424::ffs {
    struct FFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<FFS>(arg0, 6, b"FFS", b"test", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRuICAABXRUJQVlA4INYCAABQFwCdASqAAIAAPm02lkekIyIhKZG4iIANiUASsH8l/IDY0uzcaryN4A4zI2Ho18aTlPzh6EnSA8wHmv/3j9jvdH/2P4B7AH+Z/lfAN9K5+5noAdf/wzONVQViSrLnezneWWuwOXIbXGCj5DlsupOWxEi2I5fu0jYrWx37dbLNbaUjZSc+0RMZC51tvCj8cT5XwNAsmpYPvjWlIM2dW8DtVIj/3fJH7YM1heDE8sVZDlqErO55U7/12tfs44Ml3bToXiAA/vwb2FkPaAADT8Nz+7DfI57aurKhXILdS6OrS+7AeZu6o/dUhIzuPgyRaoPAlbxlTgLSPORCA0DsxcAkf7FeCRpbHJcMJVfWGsdeIwKMHRu38extOH2psPGij4nmr7yOr/t5Gf1k7AKTv6ax1vixgUMxtjmDJYYBErnym2haAtd4Lljb8uMClV/C2ItbXFmBwLGt9nM63ISQRZiQ0GEXUGqPtmte15aE6G9HorYKTfdu1sMgcbgeRcd80S4g0mBXQv1NO/PtOjHerA56EXkVnydZ4NEDx/e9UIqldaAXHviQiCjqwQZACc7iGEor8VXQHxtjWLOZF9whwh9IhW9GrZJKaVjOr9ENU8FcLiZ96QkeT3BleTMXXA/ehELm9mnfi2AMPIXsON9TxDPeTFwUuGyeF5gXdYz1d5O2NG8QdH0FG45CRjTy+LfHtqh7XZdoud1x+ORUy+oyauQfAbCPDTzclSQIfaKOvaKEzU+aPXvPaQBkCdBNNkdc0wSh4QRXrOpFLn0P9/bE2BD69D782HRsiZNydhQsoyr2qz6D89mot+n11tM3gwjO/QPNgL+UTMncqdOmtHHWxn+MdLutu8o40lILKwOoZMbcSxQ0Dar+zCCu6QbgWWr+O3hSlXg5I5gW+fmKruNOfR7UGh7GIGkGcZaWccN2xG6LidmcGKlq0qtuIZgFj49wxi6WyAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

