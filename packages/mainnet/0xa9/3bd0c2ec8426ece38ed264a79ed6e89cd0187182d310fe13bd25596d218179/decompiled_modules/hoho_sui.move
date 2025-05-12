module 0xa93bd0c2ec8426ece38ed264a79ed6e89cd0187182d310fe13bd25596d218179::hoho_sui {
    struct HOHO_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOHO_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOHO_SUI>(arg0, 9, b"hohoSUI", b"fatima Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAFCAYAAABvsz2cAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAjSURBVBhXY7z66Ot/BgYGBiYGBgaG/wwMDEz/GSCACUojGADVcAWzR805ewAAAABJRU5ErkJggg==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOHO_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOHO_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

