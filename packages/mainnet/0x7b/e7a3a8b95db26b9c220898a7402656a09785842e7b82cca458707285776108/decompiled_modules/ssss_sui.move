module 0x7be7a3a8b95db26b9c220898a7402656a09785842e7b82cca458707285776108::ssss_sui {
    struct SSSS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSS_SUI>(arg0, 9, b"ssssSUI", b"11111 Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRjQDAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBkAAAABDzD/ERFCTdsGTPiTDoaOI6L/SRzeG3EAAFZQOCD0AgAAUBQAnQEqgACAAD5tNpZIpCKiISGVWwCADYlnANUls8gGF/qdmUpgl7GkgkgDXFfxg3yp8GOvDXLoHU810mUPM/v/we6iURn1bkHWThJatGMJTdjmkVmswol2oShi4Cuxb6ua38WLavezV0vejqKOf6pWBgt2kj3YOEsYChEL0Wh1+afmmGiGdxGSCg/Gda7UqmOf34aCH48CjuArVm31Vyx2hvC+eHytSkNgAP78rRADE/7j4pfw7j0TdtjhJhZyFLgaO1ufVV0L0Cxwdg+pECTODrrT8oioGnKZxxMxeuK9gkyACPsKvDsWd730zw3Cqvfr57MHdrEBQqks94NsX9ZsQ7rnwFGPZfQ60BsBjbBJkbz33C6gMdWLPnluDmRr0svk3cdmKQxMokRWoL4Z+srsxcSfEn1HOrK0pu++xODnjWxXz3wg+h94TtdSuEKgg7jKtem+kSKCLItJyF9j2us+NWhPEBgaiD25Go6O9GxhvJChaUuNY4zbF3fcnHbx2l9jQ/3aEkIFKFVDOYLxq0c+sumlixqQv/whZmZ9zFOocCdwxLud6K5yDVGWVU5yQE6WRY0sBE7Q04HhBQOxi1TyRzvoRqxCbWFLDtAc531bF0Al3Up4JnxebNnOjm5GS+imKCndgq8G1x9luZRhEFSxSGxWWDOTf//TUzKkAlgwhqzU6UxYmb+WpxLtamyfOmFbeEdERAJA89tFEhGzVSxAszBXuv2erYwnpAO3Z/Q/ZBWXeO4st2vtWr2dOrgHMVsqlFsblnJxXroYNeQpKV+GEU9qDATIY82qjnSY4GM8MR+sQmORhqC+p13C7r6bevbu/wWFKYXJNbSUo0amDUYrEcWUrEz0OU5aWKNhJ2fnHE/G07t+wdt+2pqseMkrrQ4Yn/wtyRoU03vKDzx+8Ox94+3foE/QH6xUEOtqjGTt7Gnz5VcOclzVvi1VoYcNZp0PrWh9b869MxBa0Q3d1g1MJRuwhI4I58prNPu1yAAAAAAA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSSS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

