module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic {
    struct COSMETIC has drop {
        dummy_field: bool,
    }

    struct Equip has drop {
        dummy_field: bool,
    }

    struct Cosmetic has store, key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        model_url: 0x1::string::String,
        texture_url: 0x1::string::String,
        type: 0x1::string::String,
        formatted_type: 0x1::string::String,
        colour_way: 0x1::string::String,
        edition: 0x1::string::String,
        manufacturer: 0x1::string::String,
        rarity: 0x1::string::String,
        wear_rating: u64,
        misc: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun new(arg0: vector<u8>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : Cosmetic {
        Cosmetic{
            id             : 0x2::object::new(arg11),
            hash           : arg0,
            name           : arg1,
            image_url      : arg2,
            model_url      : arg3,
            texture_url    : arg4,
            type           : arg5,
            formatted_type : 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::make_formatted_type(arg5),
            colour_way     : arg6,
            edition        : arg7,
            manufacturer   : arg8,
            rarity         : arg9,
            wear_rating    : arg10,
            misc           : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public(friend) fun colour_way(arg0: &Cosmetic) : 0x1::string::String {
        arg0.colour_way
    }

    public(friend) fun edition(arg0: &Cosmetic) : 0x1::string::String {
        arg0.edition
    }

    public(friend) fun equip<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<Cosmetic>, arg6: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String, vector<u8>) {
        let v0 = 0x2::kiosk::borrow<Cosmetic>(arg3, arg4, arg2);
        let v1 = Equip{dummy_field: false};
        0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::item::equip<T0, Equip, Cosmetic>(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg6);
        (v0.name, v0.type, v0.hash)
    }

    public(friend) fun formatted_type(arg0: &Cosmetic) : 0x1::string::String {
        arg0.formatted_type
    }

    public(friend) fun hash(arg0: &Cosmetic) : vector<u8> {
        arg0.hash
    }

    public(friend) fun image_url(arg0: &Cosmetic) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: COSMETIC, arg1: &mut 0x2::tx_context::TxContext) {
        0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::item::init_state<COSMETIC, Equip, Cosmetic>(arg0, 0x1::string::utf8(b"{name} {formatted_type}"), 0x1::string::utf8(b"A cosmetic built in the laser forges of ACT, an Anima Nexus world."), arg1);
    }

    public(friend) fun manufacturer(arg0: &Cosmetic) : 0x1::string::String {
        arg0.manufacturer
    }

    public(friend) fun model_url(arg0: &Cosmetic) : 0x1::string::String {
        arg0.model_url
    }

    public(friend) fun name(arg0: &Cosmetic) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun rarity(arg0: &Cosmetic) : 0x1::string::String {
        arg0.rarity
    }

    public(friend) fun texture_url(arg0: &Cosmetic) : 0x1::string::String {
        arg0.texture_url
    }

    public(friend) fun type_(arg0: &Cosmetic) : 0x1::string::String {
        arg0.type
    }

    public(friend) fun unequip<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Cosmetic>) : 0x1::string::String {
        0x2::kiosk::borrow<Cosmetic>(arg2, arg3, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::item::unequip<T0, Cosmetic>(arg0, arg1, arg2, arg3, arg4)).name
    }

    public(friend) fun wear_rating(arg0: &Cosmetic) : u64 {
        arg0.wear_rating
    }

    // decompiled from Move bytecode v6
}

