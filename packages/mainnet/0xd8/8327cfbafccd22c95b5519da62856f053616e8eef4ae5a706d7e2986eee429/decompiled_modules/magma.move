module 0xd88327cfbafccd22c95b5519da62856f053616e8eef4ae5a706d7e2986eee429::magma {
    struct MAGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGMA>(arg0, 9, b"MAGMA", b"0x9f854b3ad20f8161ec0886f15f4a1752bf75d22261556f14cc8d3a1c5d50e529::magma::MAGMA", b"Building the most adaptive liquidity engine on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yellow-fascinating-hornet-971.mypinata.cloud/ipfs/bafkreihzqruw2jhz4sihh2oorwyq44cragyhngrxvprdespoguyu7vejbi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

