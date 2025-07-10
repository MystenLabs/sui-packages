module 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        fee_rate: u64,
        coin_type_x: 0x1::type_name::TypeName,
        coin_type_y: 0x1::type_name::TypeName,
        pair: 0x1::string::String,
        tick_lower_index: 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i32::I32,
        tick_upper_index: 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i32::I32,
        liquidity: u128,
        fee_growth_inside_x_last: u128,
        fee_growth_inside_y_last: u128,
        coins_owed_x: u64,
        coins_owed_y: u64,
        reward_infos: vector<PositionRewardInfo>,
    }

    struct PositionRewardInfo has copy, drop, store {
        reward_growth_inside_last: u128,
        coins_owed_reward: u64,
    }

    public(friend) fun close(arg0: Position) {
        let Position {
            id                       : v0,
            pool_id                  : _,
            fee_rate                 : _,
            coin_type_x              : _,
            coin_type_y              : _,
            pair                     : _,
            tick_lower_index         : _,
            tick_upper_index         : _,
            liquidity                : _,
            fee_growth_inside_x_last : _,
            fee_growth_inside_y_last : _,
            coins_owed_x             : _,
            coins_owed_y             : _,
            reward_infos             : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun coins_owed_reward(arg0: &Position, arg1: u64) : u64 {
        if (arg1 >= 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            0
        } else {
            0x1::vector::borrow<PositionRewardInfo>(&arg0.reward_infos, arg1).coins_owed_reward
        }
    }

    public fun coins_owed_x(arg0: &Position) : u64 {
        arg0.coins_owed_x
    }

    public fun coins_owed_y(arg0: &Position) : u64 {
        arg0.coins_owed_y
    }

    public(friend) fun decrease_debt(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.coins_owed_x = arg0.coins_owed_x - arg1;
        arg0.coins_owed_y = arg0.coins_owed_y - arg2;
    }

    public(friend) fun decrease_reward_debt(arg0: &mut Position, arg1: u64, arg2: u64) {
        let v0 = try_borrow_mut_reward_info(arg0, arg1);
        v0.coins_owed_reward = v0.coins_owed_reward - arg2;
    }

    public fun fee_growth_inside_x_last(arg0: &Position) : u128 {
        arg0.fee_growth_inside_x_last
    }

    public fun fee_growth_inside_y_last(arg0: &Position) : u128 {
        arg0.fee_growth_inside_y_last
    }

    public fun fee_rate(arg0: &Position) : u64 {
        arg0.fee_rate
    }

    public(friend) fun increase_debt(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.coins_owed_x = arg0.coins_owed_x + arg1;
        arg0.coins_owed_y = arg0.coins_owed_y + arg2;
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v1 = 0x2::display::new<Position>(&v0, arg1);
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"TradePort Position NFT"));
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"TradePort Position NFT"));
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml,%3Csvg%20width%3D%22512%22%20height%3D%22512%22%20viewBox%3D%220%200%20512%20512%22%20fill%3D%22none%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Cstyle%3E%20%20%40font-face%20%7B%20%20%20%20%20font-family%3A%20%22Inter%22%3B%20%20%20%20src%3A%20url(data%3Aapplication%2Foctet-stream%3Bbase64%2Cd09GMgABAAAAABG4AAoAAAAAH8wAABFqAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABmAAgnIKrlymYwuBBgABNgIkA4IIBCAFhjwHgSYbmBqjonZxWjCyfx7YxlKHg6MRhBimNis4eQRNd5j%2FxqMfEOoKjWMkGSBHSDLrx%2Bss30jzDTPCQ0RJPkCwrMZ7EPBeiKgKl2FDCJoqPDy%2FzZ72NoaF2WD2bEKR8msj2tjQNqgITsHcZi1a3cb0VNxmobesJKrd3gG9Z80EGCcQpLbN2LckmEd4j3CAb24dgGJ%2Frn3abHG3ZXUnS0fupkKBEjWi6v2XpWx%2BpjlCSIqgbs6VVC0COUDLylXYCiM79bKbbTYVzHIQrPWwx2vXahquUDUixgSzBS7yq8oVgPkjupUBzEQ%2BA%2BB%2BGsf6DNe6uRDGBja5OuDggMunuOETILBk9NbXWvpPHyj8ZN0J9AgAvMNcBNAPDIC9l9WLihQ7ZnE6mKiOdSxYcdXdjBEsQ7HaeA%2FQ%2F%2FcPMJqXKLnKFuqH1P9f%2FDcj5%2FDvh5%2FHUAFmH%2BWAo895wO8GBAYFh4SGrercnZ%2B7G3R3iGNMTP9n6LEsLK2sbWwBGHScnJEoF1c3dw9PL28fX3DJFyDjCtlh5u2xumaowy34B1qgK2FTbk0UtsvCA2GNtOLu4lIs5FK9yYu3tONxJ5EhXdiRYQ53kDznxvQKgm4FrM8TC128If3O8mEdugZDunbDOBwSdGU3D4s%2F4g13aE3vNIqncm9Qr56O3a7Qb7Lkhg4MAR4YbpYddhzNNJVK04nWicpbyYdmfns2UFXJaFwcVPa47UVtbopDBglAflrr71XG94cyCxqxNJf2UuNbVJ%2BGAsDEkta5L0x%2BCL%2BSp%2F%2B%2FQ%2FX%2BtZJKplkIz%2FJvvMmKsMFKWuyQr3zJmimHRlMxAWepZMdrJlJUBW6FilqocpBa1dp4UM91KWdqbYrZv1BKY0Vb%2BW76UC6R%2FeWRYn2tDMm3XXygv416laXysPPBHssnIicuXvIkkfK5Cj4ilO356kQlkjS9cFMyN5P98oZk%2Fzir8fzNkiyIVFv4R%2FTw8ZoPQlkySRAIHoQNNN0ndVA5i%2BNPi1iVUUc4QAUdR0quKonjRvzqVzQ9B6eylGnZnaEEiTpZrNxb0jUDx9g8cby84W%2BNl1MqBz5q40%2FQV6nP2%2BcbsV8jOVjAStnVfnwd8agjyiSjCXa1%2BthdCxvi0Mov6LIDzxyVtGJBVM5C8mIfJL6m050syYPqiWEOuo4QSKasLwgiiJTL0eGeIsjhVlOZ0cPectqqo%2FrGikDicO1bm0DyLJpaAUHCaIWrLZiIp8vgUVpsq4LB0d17tisKp2tuLig9x8NJd1gidxwy%2BnNhmtWOxKOcHBeMQPgmjlhqkelnLWlkipA2%2F%2BBeeVDPyaEmzzxSOr9ZhPIIPSo5VFFWRv7RGnhL22xBBWTesK6zOVPAzqUca%2BOjPDmpmETRkIeWVkaWFhFXH51x9%2BkV7edBCSNWsRW9jjg5jg8x45O2aqGahdfQ%2BElXAalWk1Gu9vX2Rgtiax23Hr596E6xeWbxraPismxptjqYlpv0aHREY3bLkh6iw5JsBpXR5tLgTxmqRl6P9qspZeRRiDJ8AKlu7liuHco%2B2qt0tAWKkGjpTpnvM6Hb9O3qe8IRkbS87fgvb6VMIWWE9tmloqYaPKWus5KdIbxN%2Br4iEqw%2BJbotS5p%2BbFxtCEqExiuO9%2BzEElG9P%2FqetLSds65%2FFK8mH6wrfqwpePax2mH9E3fXBKBHC2DPHCxemXwyk%2Fo39OMAMwV98bjBIa4FJeFzwIKD%2FyLxuynewJeL3jz8Zxi8CSPdDSdL8yYrcmLqK%2BMi9eBotfZU6lYes2jqVvF%2FeSO0sV5xLh7f0I7PKd6CIzeF49mEXIm4hwi83iMWXQ7sTnn9Bt9ul5lF1vGozYJShQFbqZOQwKkkiZ3jJNdaGzQXlQLNaxJxnBhZSUzg6uCV%2BqzSqc3C49FAfGiUuu9tO09teooLnrbt5Y%2BKbvpN7Eh49mIncdWUdeFFoCElMArwMLLRs083jm78fO3Z6XLx6LG%2FIu4BW8B4MuKY68xIyqs36jU4zyzyT6O3NpVOGpQdNsLiWcUUkQtJdEXSoLmkFGjcaG0TLJaWHpa0zw2HbZ%2FZqKO%2F1kylsgXeoqRthuHDoKujzRPYGBz59qxJVpJXSzs5bHUrq5FK5NWvz%2BC%2F65QPukBYUlM3f%2F9H3a5uq0Mo%2FjP8VY1UpQZcNvvCW4PMbzdaDMyc9PYtght9ki%2FZ5DlwbNlLLndsmQ5c28L%2FjbbLdYCG5iAPwLOaVMVwXUSsR6dbi3PFJcQlaKehPXTRsdSt2bPbBKdvrNqk0qJS6w2hS7rv%2BGiGG8Mh9jgmmmsna21QEXn0enypD20PkePj67N3Yxrs1Su15tSlyETgDapk7Bmyp%2F4iamZ3ypvXeCDUAeW4%2BKpEoKlcEkCVYsm1VkGtfA2gFn63%2FB27Lyi%2FIhaXX7snHCsZyeF3kSNlaWmR7d2kqgCgsYELF47uvDH4Le7o1hv9C4N4Ir%2F83GWcusceW7dLxu%2BMjRKkpkc1d%2BEGn8kQfdPVik3g1u5bX9PFs9r1h7Sg3PIBv9TCLVFZVSQcOV0cTDKc8pnyObawVtA6%2F4zeveYBvXlSjTkLK5%2Fmi3O6w0nlGGIOrcWPtha52B0ooiZ1FtcKDn1gAc3VZbRo9BLQmEq8IfCz63%2BabV3vBq8pj5fRhseza2vHsrOGy44rrw1GitTbwKaN6IhTXDM8%2BY%2F%2FjKO%2FkjS44JO2Ty6Ck6aFFw%2FCD%2FXq42z7rIdWUozhlEPa970PrGPQex3%2B6XYDnF2f7VAgbHb0eenh4FO9h03FF%2B%2Foqv1nkul%2B3bADaShGXbQo0fn0KpjuwInqsMu3un011BMdlu2T%2Ba%2F%2FX5%2FM8BxP9M3Qa3aQkczBAHdLvWZjcJp32hvUTZ%2B0kAylZg1I22MXw7ztdN%2BbnNCLZCQgWYS1HgmO929FbjoPNF%2BH2n7PLbpQ4hNFyNSYUaWuGIWtRqmd88SUdvjFNmTfP2X4KGialspJhYOVOfgqQeygLWFZPqxh5f8oTYxvDt2XSGZ5Y%2BKN5EEuhT3scc%2BUoE6zFlLKBtGDiQGYE5QoDozYVNBGwNbHrpfHIWg6act7I7WYTjHxkSGhBLoz2NG1tAmHpnog9o4BI4Uz3D0mQ4itkF2WVqtOTFapXe4Y3lIiY2KUPC56VlZRSpfSMQfq67ELslJQ0HXgcZdQTT4uVH%2FcNUDpQvGJyWwjnNxr1huL8cu0CGR2cdELzEr0fBeHGZRliQvwxs%2Fv8TKMT%2BFWJfa4gMiu0isdVWqTE9WqV6TSCiE2NsMS7qwARmN7EVYYaiOOtKVIWopdqK%2FHHJDS6aWyCvQsl4dRdjABp%2Bu2l10CFbm8TuPhmoF0eYisGbqyHl8woAYFVsbubs0pLOzKw2%2FKLKxPlg%2BlFUWXORIScHs9TaE64T4scCmgDfUOrTxM%2B5Sb0dQTRYmEEEHeg5dPOUH4JMopkPdevSK8iu7WkyXEEKoD8iRyYft9Pc%2FY1MbocskVQd2n8b01f6%2B2S8sbMehMd72p8brupn23k2VlRVIqdqy2CqOQFtFLO8ox00wOdrwjD1Ae2qQARgqRtc%2FQfJOQtZtKm%2B08Or2%2FSdLDIwvRcWLw8A4FDSyDNj0GDi%2Fv7yFVOAzbErFpEMDcds%2F2zut76vqIinj5EB5NZ4%2BdUKC%2FFXR2vLgQ%2Bvr6xsGfnlFGHr8lFFfbt86wxsQAKqnpi0rP3QzRdjV%2FVLypaaVn4MvDQyqwNxX%2FsjJWdhQ7DF2VvuRZNW0v8AYeumsGha7G6YNPuihyXC5U%2B8WBLaweDnq%2BkoFW9nBZld51sPExkIuxNxA9KSxrtY2CkwJdWqpJbNs2BQle%2B2WUNccWQkyNWR260hJf%2FKYdY3KYVdKmogJE7vtp1jcHsiAay02YB92NOZPRHJFB9m6kcWZLcgGvPR8dQk5I1J9x7bdf08fPKeudTazibIktqDYhbkOVleaWF7RkYsLT43ONRp377Xv6OHmVA0dTgWMBbSh6aGSZAoMPi8XqYSGH%2FhnMMvuerQNtoNvKqibOdQBntBLBjUiyN03TxnRMfDcoheCBmYJ25E2fY5HfaYvs6A0O6VD0ZkciFw4GO%2FvRFlufmedH%2FLbabG05sOqPRYn42ZJoPmBR2G%2FLDTbWQ%2BG%2FLYqTbJHzBk91%2FzBMQG12HkGkIA2SkaOorYbx3T9A1LvN4MZHCy62X%2FeHiD2oGJpLDKYnAOq4fnZbuVjBu7D9px8lQYaMzEZGomX%2BlJ0%2FgfRO9%2FUOFekwLN6MZE01UxR4FkH3PfXC3vUdtprWsE2jsRsCSF7olUBwnbOv04rsEWyXk4HlCt4IuNpx%2BMVUXdKnj%2FXJL6Z37nw5XZf88WPtc8Cp4Z0V%2FR2k5QtKEoz8CijvJK1QLtgAmWDYlZYlc389luX05adj3oKhG9%2BaJKZXtAbWoolxrIYwcnJ9bEx90r6WmmMXKsXi05XcOR4leKDnf5EUnQEbHwGVjr0P8lsm1HlLGpikovaAZFp3JMQjUMi1g2hGzc6a1JbwOBYhPrKiKoyS0BKQVKiK26%2FGFU1czxdJjzPKpksFLeMsWxgNLsnFrKPVihafVIKqMeuRh7U5bwlWHFXYmRGhRxbAjZoGRgDqKDpXVDepzjqgEUWg14fgM2QQaQ0tB%2BrvTqGhO1wnJgxTH%2BiOMH0mta9IvQhF8jihBDNd3tV4714juNoxayZmYHOm3tkj8V6dF0%2BUCxuO5DdM6HFnTXKkTVz2DnHq7ylYAyOtzYPQeKlBcLdbWvfwgaR%2FOKMrHerLyiSv7UjNiOX6pVK9%2BFFplL4uKjiOKrSG%2FX7m0AQq2RZUd%2Bx%2FWto4V0PDbxGVJcK1j5kLZ%2Fhs3uSZIrEID8SfZPMbZ0rMtcnwzIUSttBqmueelq7bkd8VSeSSIEjQg6PS4EIhAUQicHsi85WkmnAMC4%2BPqagNoyQKIHj%2BlLGsunCQ0VF4JL9hSo8%2Fb5QnFfHZ28VpfxSwekbaai9i4xWB4G6XtOHxQ8mAaibYv6h%2FY6bO2aPx3h0XT5RXKGN5%2FqlUb350SuLaTio1ozMN6qNmktdKU4H3w3PDncNgCCyISAy62VWAfX2jfJccdFk6qJoIxademhSn4YjeOP7mT7ZO2BdttUJX%2FTu%2FtRvQc2389%2FQ%2FjNaYpgkAsENVwX6YVOY7Y8ICO%2FXyYhYYMZikEQYU5jqoNUeBgs8hm7GN7%2BSjZTlV9IB9Jod8CZj5kISclmJWOWFBmRM3vh3gGheQZz6jOan1EBto8ECwRiWdTBu1LAAZ%2FBRs4l5wiADJ7gbWVyDUnz%2BVc%2BBheo%2BK%2F3%2FKBUjmVcHiWX5aNNgknmCrUeNgUG5tAp3QIVkIAjRlYAnTQNTkkamXAYGBodaOAjn8AAzxBzQYV1DNi6DKX1HLrWAPf0Lt4AT2GLjVIoItBt8ZFztEUHBrFoikBto8LvMCR1nGMkFCOQbLUJSFPFZH2RgjKYrh4lKUQU9dRm7484aXvp9dW1zMudXXkyiC0J4oCx4di7KxLbVRjB65GmUwJe%2F9nBxTJxPeao188B2fnx4sqbjw03zdZ3ad91IugfyHBJJe4iTx8p5pgK6wguNZwstREs63DTTw8%2FDy8g7lSPeApbFfYL5XXl7ow%2FQ8lEO4E5fSJcNtnNckzEtelXQ9wecQ8GkV50kPfO7rpkAMBqYabCXoinHZ8OHFW8DFkjyjsCJOJS4wdt2QjI2htOb5ghVReLicCgY2zsCRBkAxppURwnPNoitZCZyKPB7ya1YRQUEgxqnnlhheHOWkIlEh%2BnC4crnY%2FHjwCkmEmspyF3AF0YmB8lkesNAfKiAE0NXPyJLuB%2FpZJTEdk6cw9gWOEgyVbAKYT6d6UBB2VsjkRaYZl5FVIn%2BBcXbuAaeg74g2j%2F%2BedO1pAzy4vMGcOENCceHKjTsPnkG%2BDh%2B%2B%2FPgLEChIsBChwqwSCw0DCydOPLxrCGuQkFEAfNRJkqVIlSZdhkxUWQwgGDJizIQpM%2BYs6NLzDgEA)%3B%20%20%7D%3C%2Fstyle%3E%3Cg%20clip-path%3D%22url(%23clip0_2_131)%22%3E%3Crect%20width%3D%22512%22%20height%3D%22512%22%20fill%3D%22%23121212%22%2F%3E%3Cg%20clip-path%3D%22url(%23clip1_2_131)%22%3E%3Cpath%20d%3D%22M73.4155%2053V68.8438H49.6284C48.7297%2068.8438%2048%2068.1125%2048%2067.2118V54.632C47.9973%2053.7313%2048.727%2053%2049.6257%2053H73.4128H73.4155Z%22%20fill%3D%22%23F7A000%22%2F%3E%3Cpath%20d%3D%22M98.8487%2068.8438H73.4146V53H83.0426C91.7719%2053%2098.8515%2060.0925%2098.8515%2068.8438H98.8487Z%22%20fill%3D%22%23A66C00%22%2F%3E%3Cpath%20d%3D%22M89.218%2084.6821V105.368C89.218%20106.269%2088.4883%20107%2087.5896%20107H75.0429C74.1443%20107%2073.4146%20106.269%2073.4146%20105.368V68.8437C82.1439%2068.8437%2089.218%2075.9361%2089.218%2084.6821Z%22%20fill%3D%22%23F7A000%22%2F%3E%3Cpath%20d%3D%22M135.546%2054.632V67.2091C135.546%2068.1098%20134.816%2068.841%20133.917%2068.841H98.8497V53H133.917C134.816%2053%20135.546%2053.7313%20135.546%2054.632Z%22%20fill%3D%22%23F7A000%22%2F%3E%3Cpath%20d%3D%22M114.658%2084.6847V105.365C114.658%20106.266%20113.928%20106.997%20113.029%20106.997H100.48C99.5812%20106.997%2098.8516%20106.266%2098.8516%20105.365V68.8437C107.581%2068.8437%20114.66%2075.9361%20114.66%2084.6874L114.658%2084.6847Z%22%20fill%3D%22%23A66C00%22%2F%3E%3C%2Fg%3E%3Ctext%20font-size%3D%2248%22%20fill%3D%22%23FFFFFF%22%20x%3D%2248%22%20y%3D%22178%22%20font-family%3D%22Inter%2C%20sans-serif%22%3ETradePort%3C%2Ftext%3E%3Ctext%20font-size%3D%2248%22%20fill%3D%22%23FFFFFF%22%20x%3D%2248%22%20y%3D%22236%22%20font-family%3D%22Inter%2C%20sans-serif%22%3EPosition%20NFT%3C%2Ftext%3E%3Cg%20filter%3D%22url(%23filter0_d_2_131)%22%3E%3Crect%20x%3D%22487.5%22%20y%3D%22482.5%22%20width%3D%22463%22%20height%3D%22101%22%20rx%3D%227.5%22%20transform%3D%22rotate(-180%20487.5%20482.5)%22%20fill%3D%22%230D0D0D%22%20stroke%3D%22%23434343%22%2F%3E%3Ctext%20font-size%3D%2224%22%20fill%3D%22%23A2A2A2%22%20x%3D%2242%22%20y%3D%22422%22%20font-family%3D%22Inter%2C%20sans-serif%22%3EPair%3A%3C%2Ftext%3E%3Ctext%20font-size%3D%2224%22%20fill%3D%22%23FFFFFF%22%20x%3D%22469%22%20y%3D%22422%22%20text-anchor%3D%22end%22%20font-family%3D%22Inter%2C%20sans-serif%22%3E{pair}%3C%2Ftext%3E%3Ctext%20font-size%3D%2224%22%20fill%3D%22%23A2A2A2%22%20x%3D%2242%22%20y%3D%22458%22%20font-family%3D%22Inter%2C%20sans-serif%22%3ELiquidity%3A%3C%2Ftext%3E%3Ctext%20font-size%3D%2224%22%20fill%3D%22%23A2A2A2%22%20x%3D%22469%22%20y%3D%22458%22%20text-anchor%3D%22end%22%20font-family%3D%22Inter%2C%20sans-serif%22%3E{liquidity}%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3Cdefs%3E%3Cfilter%20id%3D%22filter0_d_2_131%22%20x%3D%22-29%22%20y%3D%22332%22%20width%3D%22570%22%20height%3D%22208%22%20filterUnits%3D%22userSpaceOnUse%22%20color-interpolation-filters%3D%22sRGB%22%3E%3CfeFlood%20flood-opacity%3D%220%22%20result%3D%22BackgroundImageFix%22%2F%3E%3CfeColorMatrix%20in%3D%22SourceAlpha%22%20type%3D%22matrix%22%20values%3D%220%200%200%200%200%200%200%200%200%200%200%200%200%200%200%200%200%200%20127%200%22%20result%3D%22hardAlpha%22%2F%3E%3CfeOffset%20dy%3D%224%22%2F%3E%3CfeGaussianBlur%20stdDeviation%3D%2226.5%22%2F%3E%3CfeComposite%20in2%3D%22hardAlpha%22%20operator%3D%22out%22%2F%3E%3CfeColorMatrix%20type%3D%22matrix%22%20values%3D%220%200%200%200%200.968627%200%200%200%200%200.627451%200%200%200%200%200%200%200%200%200.1%200%22%2F%3E%3CfeBlend%20mode%3D%22normal%22%20in2%3D%22BackgroundImageFix%22%20result%3D%22effect1_dropShadow_2_131%22%2F%3E%3CfeBlend%20mode%3D%22normal%22%20in%3D%22SourceGraphic%22%20in2%3D%22effect1_dropShadow_2_131%22%20result%3D%22shape%22%2F%3E%3C%2Ffilter%3E%3CclipPath%20id%3D%22clip0_2_131%22%3E%3Crect%20width%3D%22512%22%20height%3D%22512%22%20fill%3D%22white%22%2F%3E%3C%2FclipPath%3E%3CclipPath%20id%3D%22clip1_2_131%22%3E%3Crect%20width%3D%2287.6393%22%20height%3D%2254%22%20fill%3D%22white%22%20transform%3D%22translate(48%2053)%22%2F%3E%3C%2FclipPath%3E%3C%2Fdefs%3E%3C%2Fsvg%3E"));
        0x2::display::update_version<Position>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_empty(arg0: &Position) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            if (0x1::vector::borrow<PositionRewardInfo>(&arg0.reward_infos, v1).coins_owed_reward != 0) {
                v0 = false;
                break
            };
            v1 = v1 + 1;
        };
        if (arg0.liquidity == 0) {
            if (arg0.coins_owed_x == 0) {
                if (arg0.coins_owed_y == 0) {
                    v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public(friend) fun open(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: 0x1::string::String, arg5: 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i32::I32, arg6: 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i32::I32, arg7: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id                       : 0x2::object::new(arg7),
            pool_id                  : arg0,
            fee_rate                 : arg1,
            coin_type_x              : arg2,
            coin_type_y              : arg3,
            pair                     : arg4,
            tick_lower_index         : arg5,
            tick_upper_index         : arg6,
            liquidity                : 0,
            fee_growth_inside_x_last : 0,
            fee_growth_inside_y_last : 0,
            coins_owed_x             : 0,
            coins_owed_y             : 0,
            reward_infos             : 0x1::vector::empty<PositionRewardInfo>(),
        }
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun reward_growth_inside_last(arg0: &Position, arg1: u64) : u128 {
        if (arg1 >= 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            0
        } else {
            0x1::vector::borrow<PositionRewardInfo>(&arg0.reward_infos, arg1).reward_growth_inside_last
        }
    }

    public fun reward_length(arg0: &Position) : u64 {
        0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)
    }

    public fun tick_lower_index(arg0: &Position) : 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i32::I32 {
        arg0.tick_lower_index
    }

    public fun tick_upper_index(arg0: &Position) : 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i32::I32 {
        arg0.tick_upper_index
    }

    fun try_borrow_mut_reward_info(arg0: &mut Position, arg1: u64) : &mut PositionRewardInfo {
        if (arg1 >= 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            let v0 = PositionRewardInfo{
                reward_growth_inside_last : 0,
                coins_owed_reward         : 0,
            };
            0x1::vector::push_back<PositionRewardInfo>(&mut arg0.reward_infos, v0);
        };
        0x1::vector::borrow_mut<PositionRewardInfo>(&mut arg0.reward_infos, arg1)
    }

    public(friend) fun update(arg0: &mut Position, arg1: 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i128::I128, arg2: u128, arg3: u128, arg4: vector<u128>) {
        let v0 = if (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i128::eq(arg1, 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::i128::zero())) {
            if (arg0.liquidity == 0) {
                abort 0
            };
            arg0.liquidity
        } else {
            0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::liquidity_math::add_delta(arg0.liquidity, arg1)
        };
        let v1 = 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u128::mul_div_floor(0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u128::wrapping_sub(arg2, arg0.fee_growth_inside_x_last), arg0.liquidity, 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_q64());
        let v2 = 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u128::mul_div_floor(0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u128::wrapping_sub(arg3, arg0.fee_growth_inside_y_last), arg0.liquidity, 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_q64());
        if (v1 > (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_max_u64() as u128) || v2 > (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_max_u64() as u128)) {
            abort 1
        };
        if (!0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u64::add_check(arg0.coins_owed_x, (v1 as u64)) || !0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u64::add_check(arg0.coins_owed_y, (v2 as u64))) {
            abort 1
        };
        update_reward_infos(arg0, arg4);
        arg0.liquidity = v0;
        arg0.fee_growth_inside_x_last = arg2;
        arg0.fee_growth_inside_y_last = arg3;
        arg0.coins_owed_x = arg0.coins_owed_x + (v1 as u64);
        arg0.coins_owed_y = arg0.coins_owed_y + (v2 as u64);
    }

    fun update_reward_infos(arg0: &mut Position, arg1: vector<u128>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            let v1 = arg0.liquidity;
            let v2 = *0x1::vector::borrow<u128>(&arg1, v0);
            let v3 = try_borrow_mut_reward_info(arg0, v0);
            let v4 = 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u128::mul_div_floor(0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u128::wrapping_sub(v2, v3.reward_growth_inside_last), v1, 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_q64());
            if (v4 > (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_max_u64() as u128) || !0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::full_math_u64::add_check(v3.coins_owed_reward, (v4 as u64))) {
                abort 1
            };
            v3.reward_growth_inside_last = v2;
            v3.coins_owed_reward = v3.coins_owed_reward + (v4 as u64);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

