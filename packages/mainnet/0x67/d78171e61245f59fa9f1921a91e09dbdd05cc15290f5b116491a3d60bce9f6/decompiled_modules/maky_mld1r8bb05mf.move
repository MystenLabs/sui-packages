module 0x67d78171e61245f59fa9f1921a91e09dbdd05cc15290f5b116491a3d60bce9f6::maky_mld1r8bb05mf {
    struct MAKY_MLD1R8BB05MF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKY_MLD1R8BB05MF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKY_MLD1R8BB05MF>(arg0, 9, b"MAKY", b"Maky insaciable cat", x"4d616b793a206c612063617a61646f72612063616c6c656a6572612064652076656c6173207665726465732e2052c3a1706964612c2063617574656c6f7361207920636f6e20756e2068616d62726520696e7361636961626c65206465206365726f732e204e6f20647565726d652c20736f6c6f2063617a612068617374612061676f74617220656c206174c3ba6e206465206c6120626c6f636b636861696e2e20c2a1c39a6e657465207920616c696d656e74612061206c61206761746121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/Qmaxs4FDzDbw9JRW86SoryEBRMcKoF6BfcYoPSzTB11yh7")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAKY_MLD1R8BB05MF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKY_MLD1R8BB05MF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

