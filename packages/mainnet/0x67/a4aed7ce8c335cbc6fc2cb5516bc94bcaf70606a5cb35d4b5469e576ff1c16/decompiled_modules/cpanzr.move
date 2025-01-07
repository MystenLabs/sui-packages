module 0x67a4aed7ce8c335cbc6fc2cb5516bc94bcaf70606a5cb35d4b5469e576ff1c16::cpanzr {
    struct CPANZR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPANZR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPANZR>(arg0, 6, b"cPANZR", b"Panzerdogs", b"Panzerdogs are finally launching their highly anticipated $cPANZR token! Join an epic PvP tank brawler game that is available on the desktop. The TOP 25 Holders receive our exclusive NFT airdrop & all PumpFun participants receive a small amount of token airdrop! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/435345678_cd863145ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPANZR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPANZR>>(v1);
    }

    // decompiled from Move bytecode v6
}

