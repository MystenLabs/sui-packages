module 0x582180b90a50adf9e114360a02def7aff49de0796770e6b68127a2c8cfad496e::d_sui {
    struct D_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: D_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D_SUI>(arg0, 9, b"dSUI", b"Drip Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRugDAABXRUJQVlA4INwDAABwGACdASqAAIAAPm02lkgkIyIhJBIKkIANiUAa1MIH+8efzt4d4sA53W75R6j3mAfpH0xvMB5uvoI/wHqAdJv6Ffls+yd+5GUmw/y5eDekdmfeSSiK9bhLWFqnwLSvheUkY8IEUGAcfhVpkP1MRvOVHYWSI4PN0cpfedH5PjQjOXfpfXfsCSkEqyXGRYxbGKRNZjsBF+ZYV/pcP0qu69vEcJo9oKtMH7DbvokxECPhZQVxMOnfzNSa4GSyV5doMHLfmGbh3UHp75sVaVAA/vp5Su1uAAYwMnrhPtawksy3A1anTaii8c/Wd7SdTmBUjuVREFNLjQDdNT4Y6f03ZPpWXrJn7gJyAPKX0QXx5z0JNbS1RmNPKIEy0v94SzP34RATRdeScrPQBRyJ2oaCep3kIdoaCQeCc8sp9ArX28XGrbPie61y5v87PfC3Qqf/iYvy3jhxNdr/l2d2BjDef9W+DjkUruSLeNVUN6inUBH2XjA04hm2igDbnWvD7wzkStq3J3oW/xofu/JAUJsuRua3MH+gYBHkKT5EbsR7cyAQ1iI8WrXCbiJfvak5xxMGYn1hlywOYPLG9kTAS37DZjJe9+IDfn7evSAQz37Q1U636dXHuTbWeEfxc+5ogV8XHPPwuuVYu5t4vD/NCTysQhv34/d9BHoI8guTZ44zP12d5WB1tjR9o+vhZXwZBAC8nWAW2JglR26mxGSrZX30nz6U5ex1dig3PihN1MoeTPUDJvAUWc0/wvbNgnf1WkrJ5C//rj9yoNxvw5dKxYfoVfDkiic3i2M7WibUPFhRGky18cbIFHbp32YE9ftMtqL4/i0ZXImEMpZiAZCvj1JhZQefiCcZ1Jhy45SWUqFM2z7YIhzeFT6d7190dWDWeCF7K7XPTZTCc571tcYlJcnRr2qm0Hj4/csxsmMtYcMNuU3nAZHD2wYnU8WsfxVWCmbStfQydnhn7cpS+Vcc+HA7kNyibQFO72ZR0HGj1LDWwLUWubM3oOpIHkGeqrCRwsg8wc/5VefnnmWOoJrsSVfZTXGTnnIaw2aJzCRi+Jkkar8f4+PvkOBjGKS1pNqHXqNRWfV2OeCXurXuknaZ9BJT7TMT9t21rxINyz3UnHh22O3AasKZ+hNima9iy97+RY1CI/NjQBlqQ70cAmHL7KeW9vdrkYaoRnLsS+SIFQntRt2ldKmUL8nFi5uoGGG1xcIMJPDe5jUlvzFm0V03XRsx8qhWkbMJFwOuGfZ6KDT0rvfxOEe5Cn8tP0HRbUe8sBZXJZru0iCQ/7fSwAyMYIPw+U+KUWlEB4kzQ5oAAAAA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<D_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

