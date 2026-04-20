module 0x86fa13bea04aa08030676a760b48d72096638dbd2df2da397b04e4e846319343::eth_above_dollar230914_on_apr_20_1300_utc_1776686402324_no {
    struct ETH_ABOVE_DOLLAR230914_ON_APR_20_1300_UTC_1776686402324_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH_ABOVE_DOLLAR230914_ON_APR_20_1300_UTC_1776686402324_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH_ABOVE_DOLLAR230914_ON_APR_20_1300_UTC_1776686402324_NO>(arg0, 0, b"ETH_ABOVE_DOLLAR230914_ON_APR_20_1300_UTC_1776686402324_NO", b"ETH_ABOVE_DOLLAR230914_ON_APR_20_1300_UTC_1776686402324 NO", b"ETH_ABOVE_DOLLAR230914_ON_APR_20_1300_UTC_1776686402324 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETH_ABOVE_DOLLAR230914_ON_APR_20_1300_UTC_1776686402324_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH_ABOVE_DOLLAR230914_ON_APR_20_1300_UTC_1776686402324_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

