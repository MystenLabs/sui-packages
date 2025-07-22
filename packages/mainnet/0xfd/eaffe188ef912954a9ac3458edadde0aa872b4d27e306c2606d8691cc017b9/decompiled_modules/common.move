module 0xfdeaffe188ef912954a9ac3458edadde0aa872b4d27e306c2606d8691cc017b9::common {
    struct Prize has copy, drop, store {
        tier_level: u64,
        quantity: u64,
        remaining: u64,
        prize_name: vector<u8>,
        prize_description: vector<u8>,
        has_physical_prize: bool,
        physical_prize_name: vector<u8>,
        physical_prize_description: vector<u8>,
    }

    struct KioskSettings has copy, drop, store {
        enabled: bool,
    }

    struct CampaignStatus has copy, drop, store {
        value: u8,
    }

    public fun already_claimed() : u64 {
        9
    }

    public fun already_revealed() : u64 {
        10
    }

    public fun already_shuffled() : u64 {
        7
    }

    public fun campaign_not_active() : u64 {
        25
    }

    public fun campaign_not_in_claim() : u64 {
        3
    }

    public fun campaign_not_in_reveal() : u64 {
        6
    }

    public fun campaign_paused() : u64 {
        30
    }

    public(friend) fun create_campaign_status(arg0: u8) : CampaignStatus {
        CampaignStatus{value: arg0}
    }

    public(friend) fun create_prize(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: vector<u8>, arg6: vector<u8>) : Prize {
        assert!(arg0 > 0, invalid_tier());
        Prize{
            tier_level                 : arg0,
            quantity                   : arg1,
            remaining                  : arg1,
            prize_name                 : arg2,
            prize_description          : arg3,
            has_physical_prize         : arg4,
            physical_prize_name        : arg5,
            physical_prize_description : arg6,
        }
    }

    public(friend) fun decrement_prize_remaining(arg0: &mut Prize) {
        assert!(arg0.remaining > 0, error_no_prizes_remaining());
        arg0.remaining = arg0.remaining - 1;
    }

    public fun default_kiosk_settings() : KioskSettings {
        KioskSettings{enabled: true}
    }

    public fun emergency_paused() : u64 {
        32
    }

    public fun error_no_prizes_remaining() : u64 {
        29
    }

    public fun get_status_value(arg0: &CampaignStatus) : u8 {
        arg0.value
    }

    public fun invalid_nft_id() : u64 {
        28
    }

    public fun invalid_nonce() : u64 {
        31
    }

    public fun invalid_prize_quantity() : u64 {
        23
    }

    public fun invalid_random_value() : u64 {
        27
    }

    public fun invalid_royalty_percentage() : u64 {
        20
    }

    public fun invalid_status() : u64 {
        2
    }

    public fun invalid_status_transition() : u64 {
        24
    }

    public fun invalid_tier() : u64 {
        11
    }

    public fun item_not_found() : u64 {
        19
    }

    public fun kiosk_not_enabled() : u64 {
        16
    }

    public fun kiosk_settings_enabled(arg0: &KioskSettings) : bool {
        arg0.enabled
    }

    public fun listing_not_enabled() : u64 {
        17
    }

    public fun no_prize_assigned() : u64 {
        14
    }

    public fun non_sequential_tier() : u64 {
        26
    }

    public fun not_authorized() : u64 {
        1
    }

    public fun not_owner() : u64 {
        12
    }

    public fun not_revealed() : u64 {
        15
    }

    public fun not_shuffled() : u64 {
        8
    }

    public fun price_too_low() : u64 {
        18
    }

    public fun prize_description(arg0: &Prize) : vector<u8> {
        arg0.prize_description
    }

    public fun prize_has_physical(arg0: &Prize) : bool {
        arg0.has_physical_prize
    }

    public fun prize_name(arg0: &Prize) : vector<u8> {
        arg0.prize_name
    }

    public fun prize_physical_description(arg0: &Prize) : vector<u8> {
        arg0.physical_prize_description
    }

    public fun prize_physical_name(arg0: &Prize) : vector<u8> {
        arg0.physical_prize_name
    }

    public fun prize_quantity(arg0: &Prize) : u64 {
        arg0.quantity
    }

    public fun prize_quantity_exceeded() : u64 {
        21
    }

    public fun prize_remaining(arg0: &Prize) : u64 {
        arg0.remaining
    }

    public fun prize_tier_level(arg0: &Prize) : u64 {
        arg0.tier_level
    }

    public fun prizes_exceed_total_supply() : u64 {
        22
    }

    public(friend) fun set_prize_remaining(arg0: &mut Prize, arg1: u64) {
        assert!(arg1 <= arg0.quantity, invalid_prize_quantity());
        arg0.remaining = arg1;
    }

    public fun status_claim() : CampaignStatus {
        CampaignStatus{value: 1}
    }

    public fun status_draft() : CampaignStatus {
        CampaignStatus{value: 0}
    }

    public fun status_equals(arg0: &CampaignStatus, arg1: &CampaignStatus) : bool {
        arg0.value == arg1.value
    }

    public fun status_finished() : CampaignStatus {
        CampaignStatus{value: 4}
    }

    public fun status_reveal() : CampaignStatus {
        CampaignStatus{value: 3}
    }

    public fun status_shuffled() : CampaignStatus {
        CampaignStatus{value: 2}
    }

    public fun supply_exceeded() : u64 {
        5
    }

    public fun wrong_registry() : u64 {
        13
    }

    // decompiled from Move bytecode v6
}

