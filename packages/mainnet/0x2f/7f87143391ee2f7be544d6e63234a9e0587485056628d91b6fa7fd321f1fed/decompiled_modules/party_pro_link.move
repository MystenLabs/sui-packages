module 0x2f7f87143391ee2f7be544d6e63234a9e0587485056628d91b6fa7fd321f1fed::party_pro_link {
    struct WebsiteData has copy, drop, store {
        url: 0x1::string::String,
    }

    struct BookingPageData has copy, drop, store {
        url: 0x1::string::String,
    }

    struct ManagementPageData has copy, drop, store {
        url: 0x1::string::String,
    }

    struct PublisherPageData has copy, drop, store {
        url: 0x1::string::String,
    }

    struct LabelPageData has copy, drop, store {
        url: 0x1::string::String,
    }

    struct EpkData has copy, drop, store {
        url: 0x1::string::String,
    }

    struct PatreonData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct SubstackData has copy, drop, store {
        subdomain: 0x1::string::String,
    }

    struct KofiData has copy, drop, store {
        handle: 0x1::string::String,
    }

    public fun booking_page(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<BookingPageData> {
        validate_url(&arg0);
        let v0 = BookingPageData{url: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<BookingPageData>(v0)
    }

    public fun booking_url(arg0: &BookingPageData) : 0x1::string::String {
        arg0.url
    }

    public fun epk(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<EpkData> {
        validate_url(&arg0);
        let v0 = EpkData{url: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<EpkData>(v0)
    }

    public fun epk_url(arg0: &EpkData) : 0x1::string::String {
        arg0.url
    }

    public fun kofi(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<KofiData> {
        validate_handle(&arg0);
        let v0 = KofiData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<KofiData>(v0)
    }

    public fun kofi_handle(arg0: &KofiData) : 0x1::string::String {
        arg0.handle
    }

    public fun label_page(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<LabelPageData> {
        validate_url(&arg0);
        let v0 = LabelPageData{url: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<LabelPageData>(v0)
    }

    public fun label_url(arg0: &LabelPageData) : 0x1::string::String {
        arg0.url
    }

    public fun management_page(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<ManagementPageData> {
        validate_url(&arg0);
        let v0 = ManagementPageData{url: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<ManagementPageData>(v0)
    }

    public fun management_url(arg0: &ManagementPageData) : 0x1::string::String {
        arg0.url
    }

    public fun patreon(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<PatreonData> {
        validate_handle(&arg0);
        let v0 = PatreonData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<PatreonData>(v0)
    }

    public fun patreon_handle(arg0: &PatreonData) : 0x1::string::String {
        arg0.handle
    }

    public fun publisher_page(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<PublisherPageData> {
        validate_url(&arg0);
        let v0 = PublisherPageData{url: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<PublisherPageData>(v0)
    }

    public fun publisher_url(arg0: &PublisherPageData) : 0x1::string::String {
        arg0.url
    }

    public fun substack(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<SubstackData> {
        validate_handle(&arg0);
        let v0 = SubstackData{subdomain: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<SubstackData>(v0)
    }

    public fun substack_subdomain(arg0: &SubstackData) : 0x1::string::String {
        arg0.subdomain
    }

    fun validate_handle(arg0: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 0);
        assert!(0x1::string::length(arg0) <= 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::max_identifier_length(), 2);
    }

    fun validate_url(arg0: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 0);
        assert!(0x1::string::length(arg0) <= 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::max_url_length(), 1);
    }

    public fun website(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<WebsiteData> {
        validate_url(&arg0);
        let v0 = WebsiteData{url: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<WebsiteData>(v0)
    }

    public fun website_url(arg0: &WebsiteData) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v7
}

