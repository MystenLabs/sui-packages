module 0x3677bc5deebc30d792993bfb1f4152c22793c90e109f9074ebe8c80c54eff75c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0942494b455459534f4e0a42494b45205459534f4e0a46756e6e79204d656d65e50168747470733a2f2f696d616765732e70756d702e66756e2f636f696e2d696d6167652f436279544e663755507a7665774868345a7036756d6f674d3252576168686d47524a574c4a6e507770756d703f76617269616e743d3630307836303026697066733d516d52485478436556786f3639554a5a3378774832727551797935486f543441554454356e346a334a6f6270627a267372633d6874747073253341253246253246697066732e696f25324669706673253246516d52485478436556786f3639554a5a3378774832727551797935486f543441554454356e346a334a6f6270627a");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

