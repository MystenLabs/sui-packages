module 0x648f9eab1434c056d509ad857fb657ac170528798d771f7eb1edc35639e3e75c::movecoin {
    struct MOVECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECOIN>(arg0, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::mcoin_decimals(), 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::move_tick(), 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::move_tick(), b"MOVE coin of Movescription", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gk4id6fee24ru5cdipjxyz6cl42yjtzl3xfuizlpqjub42hx5rvq.arweave.net/MriB-KQmuRp0Q0PTfGfCXzWEzyvdy0Rlb4JoHmj37Gs")), arg1);
        0x2::transfer::public_share_object<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::InitTreasuryArgs<MOVECOIN>>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::new_init_treasury_args<MOVECOIN>(0x1::ascii::string(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::move_tick()), v0, v1, arg1));
    }

    public fun init_treasury(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::InitTreasuryArgs<MOVECOIN>) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_record(arg0, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::move_tick());
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::init_treasury<MOVECOIN>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

