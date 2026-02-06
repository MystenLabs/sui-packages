module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types {
    struct ReleaseCondition has copy, drop, store {
        condition_type: u8,
        value: u64,
        required_address: 0x1::option::Option<address>,
        is_met: bool,
    }

    struct PricingTier has copy, drop, store {
        name: vector<u8>,
        price: u64,
        description: vector<u8>,
        rate_limit: u64,
    }

    public fun basis_points_100_percent() : u64 {
        10000
    }

    public fun channel_status_closed() : u8 {
        3
    }

    public fun channel_status_closing() : u8 {
        1
    }

    public fun channel_status_disputed() : u8 {
        2
    }

    public fun channel_status_open() : u8 {
        0
    }

    public fun check_time_condition(arg0: &ReleaseCondition, arg1: u64) : bool {
        if (arg0.condition_type != 0) {
            return false
        };
        arg1 >= arg0.value
    }

    public fun condition_required_address(arg0: &ReleaseCondition) : 0x1::option::Option<address> {
        arg0.required_address
    }

    public fun condition_type(arg0: &ReleaseCondition) : u8 {
        arg0.condition_type
    }

    public fun condition_value(arg0: &ReleaseCondition) : u64 {
        arg0.value
    }

    public fun find_tier_for_amount(arg0: &vector<PricingTier>, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PricingTier>(arg0)) {
            if (arg1 >= 0x1::vector::borrow<PricingTier>(arg0, v0).price) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun invoice_status_cancelled() : u8 {
        3
    }

    public fun invoice_status_disputed() : u8 {
        2
    }

    public fun invoice_status_paid() : u8 {
        1
    }

    public fun invoice_status_pending() : u8 {
        0
    }

    public fun invoice_status_refunded() : u8 {
        5
    }

    public fun invoice_status_released() : u8 {
        4
    }

    public fun is_channel_closed(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_channel_closing(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_channel_disputed(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_channel_open(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_condition_met(arg0: &ReleaseCondition) : bool {
        arg0.is_met
    }

    public fun is_invoice_cancelled(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_invoice_disputed(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_invoice_paid(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_invoice_pending(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_invoice_refunded(arg0: u8) : bool {
        arg0 == 5
    }

    public fun is_invoice_released(arg0: u8) : bool {
        arg0 == 4
    }

    public fun is_invoice_terminal(arg0: u8) : bool {
        if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    public fun is_stream_active(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_stream_cancelled(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_stream_completed(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_stream_paused(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_stream_terminal(arg0: u8) : bool {
        arg0 == 2 || arg0 == 3
    }

    public fun mark_condition_met(arg0: &mut ReleaseCondition) {
        arg0.is_met = true;
    }

    public fun new_oracle_condition(arg0: address) : ReleaseCondition {
        ReleaseCondition{
            condition_type   : 2,
            value            : 0,
            required_address : 0x1::option::some<address>(arg0),
            is_met           : false,
        }
    }

    public fun new_pricing_tier(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64) : PricingTier {
        PricingTier{
            name        : arg0,
            price       : arg1,
            description : arg2,
            rate_limit  : arg3,
        }
    }

    public fun new_signature_condition(arg0: address) : ReleaseCondition {
        ReleaseCondition{
            condition_type   : 1,
            value            : 0,
            required_address : 0x1::option::some<address>(arg0),
            is_met           : false,
        }
    }

    public fun new_time_condition(arg0: u64) : ReleaseCondition {
        ReleaseCondition{
            condition_type   : 0,
            value            : arg0,
            required_address : 0x1::option::none<address>(),
            is_met           : false,
        }
    }

    public fun one_cent() : u64 {
        10000
    }

    public fun one_dollar() : u64 {
        1000000
    }

    public fun one_hundred_dollars() : u64 {
        100000000
    }

    public fun release_condition_oracle() : u8 {
        2
    }

    public fun release_condition_signature() : u8 {
        1
    }

    public fun release_condition_time() : u8 {
        0
    }

    public fun stream_status_active() : u8 {
        0
    }

    public fun stream_status_cancelled() : u8 {
        2
    }

    public fun stream_status_completed() : u8 {
        3
    }

    public fun stream_status_paused() : u8 {
        1
    }

    public fun ten_cents() : u64 {
        100000
    }

    public fun tier_description(arg0: &PricingTier) : vector<u8> {
        arg0.description
    }

    public fun tier_name(arg0: &PricingTier) : vector<u8> {
        arg0.name
    }

    public fun tier_price(arg0: &PricingTier) : u64 {
        arg0.price
    }

    public fun tier_rate_limit(arg0: &PricingTier) : u64 {
        arg0.rate_limit
    }

    // decompiled from Move bytecode v6
}

