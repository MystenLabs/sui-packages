module 0x2024e324db1d08d9fdadeab017257b547ec439cac2419d74d8d393cfefc4dfa8::eth_above_dollar233098_on_apr_16_1030_utc_1776334516445_no {
    struct ETH_ABOVE_DOLLAR233098_ON_APR_16_1030_UTC_1776334516445_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH_ABOVE_DOLLAR233098_ON_APR_16_1030_UTC_1776334516445_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH_ABOVE_DOLLAR233098_ON_APR_16_1030_UTC_1776334516445_NO>(arg0, 0, b"ETH_ABOVE_DOLLAR233098_ON_APR_16_1030_UTC_1776334516445_NO", b"ETH_ABOVE_DOLLAR233098_ON_APR_16_1030_UTC_1776334516445 NO", b"ETH_ABOVE_DOLLAR233098_ON_APR_16_1030_UTC_1776334516445 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETH_ABOVE_DOLLAR233098_ON_APR_16_1030_UTC_1776334516445_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH_ABOVE_DOLLAR233098_ON_APR_16_1030_UTC_1776334516445_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

