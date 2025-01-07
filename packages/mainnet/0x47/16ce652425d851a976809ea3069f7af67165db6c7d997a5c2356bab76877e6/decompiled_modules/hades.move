module 0x4716ce652425d851a976809ea3069f7af67165db6c7d997a5c2356bab76877e6::hades {
    struct HADES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HADES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HADES>(arg0, 6, b"Hades", b"SUI Hades", x"2248616465732c20796f752063616e277420706f737369626c792073756363656564220a22476976652075702c204861646573220a2248616465732c2077686174206861766520796f7520646f6e65220a48616465733a225468652063757272656e742070726f67726573732069732039392522", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/260762098_0_final_b833cdd7fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HADES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HADES>>(v1);
    }

    // decompiled from Move bytecode v6
}

